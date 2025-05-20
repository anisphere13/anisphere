/// Copilot Prompt : Service IdentityService pour AniSphère.
/// Gère l’enregistrement, la mise à jour, l’historique et la synchronisation locale/cloud
/// des fiches d’identité animale (QR, statut, photo, badge IA).
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/identity_model.dart';

class IdentityService {
  final Box<IdentityModel> localBox;
  final FirebaseFirestore firestore;

  IdentityService({
    required this.localBox,
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
  }

  Future<void> syncToFirestore(IdentityModel model) async {
    await firestore.collection('identities').doc(model.animalId).set(model.toMap());
  }

  Future<IdentityModel?> fetchFromFirestore(String animalId) async {
    final snapshot = await firestore.collection('identities').doc(animalId).get();
    if (!snapshot.exists) return null;

    return IdentityModel.fromMap(snapshot.data()!);
  }
}
