library;

class ModuleModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String? icon;
  final bool premium;

  const ModuleModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    this.icon,
    this.premium = false,
  });

  factory ModuleModel.fromMap(Map<String, dynamic> map) {
    return ModuleModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      icon: map['icon'],
      premium: map['premium'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'icon': icon,
      'premium': premium,
    };
  }
}
