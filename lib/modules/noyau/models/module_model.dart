library;

class ModuleModel {
  final String id;
  final String name;
  final String description;

  const ModuleModel({
    required this.id,
    required this.name,
    required this.description,
  });
<<<<<<< HEAD
=======

  factory ModuleModel.fromMap(Map<String, String> map) {
    return ModuleModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, String> toMap() => {
        'id': id,
        'name': name,
        'description': description,
      };
>>>>>>> codex/ajouter-widget-module_card
}
