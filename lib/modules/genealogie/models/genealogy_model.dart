class GenealogyNode {
  final String animalId;
  final String? parentId;
  final String? photoUrl;

  GenealogyNode({required this.animalId, this.parentId, this.photoUrl});

  factory GenealogyNode.fromMap(Map<String, dynamic> map) {
    return GenealogyNode(
      animalId: map['animalId'] as String,
      parentId: map['parentId'] as String?,
      photoUrl: map['photoUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'animalId': animalId,
      'parentId': parentId,
      'photoUrl': photoUrl,
    };
  }
}
