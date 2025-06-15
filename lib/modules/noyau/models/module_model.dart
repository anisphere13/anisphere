class ModuleModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final bool isPremium;

  ModuleModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.isPremium = false,
  });

  factory ModuleModel.fromMap(Map<String, dynamic> map) {
    return ModuleModel(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      isPremium: map['isPremium'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'isPremium': isPremium,
    };
  }
}
