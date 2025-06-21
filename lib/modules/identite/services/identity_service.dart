// Copilot Prompt : Service IdentityService pour AniSphère.
// Gère l’enregistrement, la mise à jour, l’historique et la synchronisation locale/cloud
// des fiches d’identité animale (QR, statut, photo, badge IA).
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anisphere/services/ia/ia_metrics_collector.dart';
import '../models/identity_model.dart';
import '../models/genealogy_model.dart';
import '../../noyau/services/storage_optimizer.dart';
import 'identity_signature_service.dart';
import 'dart:typed_data';

/// Service IdentityService pour AniSphère.
/// Gère l’enregistrement, la mise à jour, l’historique et la synchronisation locale/cloud
/// des fiches d’identité animale (QR, statut, photo, badge IA).

class IdentityService {
  final Box<IdentityModel> localBox;
  final Box<GenealogyModel>? genealogyBox;
  final FirebaseFirestore firestore;

  IdentityService({
    required this.localBox,
    this.genealogyBox,
    FirebaseFirestore? firestoreInstance,
  }) : firestore = firestoreInstance ?? FirebaseFirestore.instance;

  Future<void> saveIdentityLocally(IdentityModel model) async {
    await localBox.put(model.animalId, model);
  }

  IdentityModel? getIdentityLocally(String animalId) {
    return localBox.get(animalId);
  }

  Future<void> updateIdentityField({
    required String animalId,
    required String field,
    required String newValue,
    required String userId,
  }) async {
    final identity = localBox.get(animalId);
    if (identity == null) return;

    final updatedHistory = List<IdentityChange>.from(identity.history)
      ..add(IdentityChange(
        field: field,
        oldValue: identity.toMap()[field]?.toString() ?? '',
        newValue: newValue,
        date: DateTime.now(),
      ));

    final updatedModel = IdentityModel(
      animalId: identity.animalId,
      microchipNumber:
          field == 'microchipNumber' ? newValue : identity.microchipNumber,
      photoUrl: field == 'photoUrl' ? newValue : identity.photoUrl,
      status: field == 'status' ? newValue : identity.status,
      legalStatus: field == 'legalStatus' ? newValue : identity.legalStatus,
      verifiedByIA: identity.verifiedByIA,
      hasPublicQR: identity.hasPublicQR,
      history: updatedHistory,
    );

    await saveIdentityLocally(updatedModel);
    await IAMetricsCollector.logIdentityEvent(
      type: 'update_field',
      animalId: animalId,
      userId: userId,
      data: {'field': field, 'newValue': newValue},
    );
  }

  Future<void> syncToFirestore(IdentityModel model) async {
    await firestore.collection('identities').doc(model.animalId).set(model.toMap());
  }

  Future<void> syncGenealogyToFirestore(GenealogyModel model) async {
    await firestore.collection('genealogies').doc(model.animalId).set(model.toMap());
  }

  Future<IdentityModel?> fetchFromFirestore(String animalId) async {
    final snapshot = await firestore.collection('identities').doc(animalId).get();
    if (!snapshot.exists) return null;

    return IdentityModel.fromMap(snapshot.data()!);
  }

  Future<GenealogyModel?> fetchGenealogyFromFirestore(String animalId) async {
    final snapshot = await firestore.collection('genealogies').doc(animalId).get();
    if (!snapshot.exists) return null;
    final model = GenealogyModel.fromMap(snapshot.data()!);
    await genealogyBox?.put(animalId, model);
    return model;
  }

  Future<void> saveGenealogyLocally(GenealogyModel model) async {
    await genealogyBox?.put(model.animalId, model);
  }

  GenealogyModel? getGenealogyLocally(String animalId) {
    return genealogyBox?.get(animalId);
  }

  Future<double> computeCompletionScore(IdentityModel model) async {
    final fields = [
      model.microchipNumber,
      model.photoUrl,
      model.status,
      model.legalStatus,
    ];
    final filled =
        fields.where((e) => e != null && e.toString().trim().isNotEmpty).length;
    final score = filled / fields.length;
    final updated = IdentityModel(
      animalId: model.animalId,
      microchipNumber: model.microchipNumber,
      photoUrl: model.photoUrl,
      status: model.status,
      legalStatus: model.legalStatus,
      verifiedByIA: model.verifiedByIA,
      hasPublicQR: model.hasPublicQR,
      history: model.history,
      lastUpdate: model.lastUpdate,
      aiScore: score,
      verifiedBreed: model.verifiedBreed,
    );
    await saveIdentityLocally(updated);
    return score;
  }

  Future<bool> detectSiblingDuplicates(IdentityModel model) async {
    String? newHash = await _computePhotoHash(model.photoUrl);
    bool found = false;
    for (final other in localBox.values) {
      if (other.animalId == model.animalId) continue;
      if (model.microchipNumber != null &&
          other.microchipNumber == model.microchipNumber) {
        found = true;
        break;
      }
      if (newHash != null) {
        final otherHash = await _computePhotoHash(other.photoUrl);
        if (otherHash != null && otherHash == newHash) {
          found = true;
          break;
        }
      }
    }
    final updated = IdentityModel(
      animalId: model.animalId,
      microchipNumber: model.microchipNumber,
      photoUrl: model.photoUrl,
      status: model.status,
      legalStatus: model.legalStatus,
      verifiedByIA: model.verifiedByIA,
      hasPublicQR: model.hasPublicQR,
      history: model.history,
      lastUpdate: model.lastUpdate,
      aiScore: model.aiScore,
      verifiedBreed: found,
    );
    await saveIdentityLocally(updated);
    return found;
  }

  Future<Uint8List> signIdentityPdf(Uint8List pdfData, String signerId) async {
    final signer = IdentitySignatureService();
    return signer.signPdf(pdfData, signerId);
  }

  Future<String?> _computePhotoHash(String? path) async {
    if (path == null) return null;
    final file = File(path);
    if (!await file.exists()) return null;
    return StorageOptimizer.computeHash(file);
  }
}
