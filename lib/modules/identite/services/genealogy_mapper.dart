import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import '../models/genealogy_model.dart';
import 'identity_service.dart';

/// Mapper handling GenealogyModel persistence and sync.
class GenealogyMapper {
  final Box<GenealogyModel> localBox;
  final IdentityService identityService;
  final FirebaseFirestore firestore;

  GenealogyMapper({
    required this.localBox,
    required this.identityService,
    FirebaseFirestore? firestoreInstance,
  }) : firestore = firestoreInstance ?? FirebaseFirestore.instance;

  Future<void> saveGenealogy(GenealogyModel model) async {
    await localBox.put(model.animalId, model);
    await firestore
        .collection('genealogies')
        .doc(model.animalId)
        .set(model.toMap());
  }

  GenealogyModel? getGenealogy(String animalId) {
    return localBox.get(animalId);
  }

  Future<GenealogyModel?> fetchFromFirestore(String animalId) async {
    final snapshot =
        await firestore.collection('genealogies').doc(animalId).get();
    if (!snapshot.exists) return null;
    final model = GenealogyModel.fromMap(snapshot.data()!);
    await localBox.put(animalId, model);
    return model;
  }

  Future<GenealogyModel> mapFromData(
      String animalId, Map<String, String> data) async {
    final model = GenealogyModel(
      animalId: animalId,
      fatherId: data['fatherId'],
      motherId: data['motherId'],
      affixe: data['affixe'],
      litterNumber: data['litterNumber'],
      lofName: data['lofName'],
    );
    await saveGenealogy(model);
    return model;
  }
}
