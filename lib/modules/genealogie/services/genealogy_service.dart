import 'package:hive/hive.dart';

import '../models/genealogy_model.dart';

class GenealogyService {
  final Box<GenealogyNode> nodeBox;

  GenealogyService(this.nodeBox);

  Future<void> saveNode(GenealogyNode node) async {
    await nodeBox.put(node.animalId, node);
  }

  GenealogyNode? getNode(String animalId) => nodeBox.get(animalId);
}
