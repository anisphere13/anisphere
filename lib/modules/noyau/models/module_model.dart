class ModuleModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final String icon;
  final bool premium;
  @Deprecated('Use premium')
  final bool isPremium;

  const ModuleModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.icon = '',
    this.premium = false,
    @Deprecated('Use premium') this.isPremium = false,
  });

  factory ModuleModel.fromMap(Map<String, dynamic> map) {
    final premium = map['premium'] as bool? ?? map['isPremium'] as bool? ?? false;
    return ModuleModel(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String? ?? '',
      premium: premium,
      // ignore: deprecated_member_use_from_same_package
      isPremium: premium,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'icon': icon,
      'premium': premium,
    };
  }
}
