import 'package:flutter/material.dart';

class QuickActionsSheet extends StatelessWidget {
  final VoidCallback onAddAnimal;
  final VoidCallback onAddHealthNote;
  final VoidCallback onAddPhoto;
  final VoidCallback onAddActivity;

  const QuickActionsSheet({
    super.key,
    required this.onAddAnimal,
    required this.onAddHealthNote,
    required this.onAddPhoto,
    required this.onAddActivity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.pets),
            title: const Text('Ajouter un animal'),
            onTap: onAddAnimal,
          ),
          ListTile(
            leading: const Icon(Icons.note_add),
            title: const Text('Nouvelle note santé'),
            onTap: onAddHealthNote,
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Ajouter une photo'),
            onTap: onAddPhoto,
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Ajouter une activité'),
            onTap: onAddActivity,
          ),
        ],
      ),
    );
  }
}
