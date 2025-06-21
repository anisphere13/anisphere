// Copilot Prompt : Écran de création/modification d’un animal dans AniSphère.
// Permet à l’utilisateur de saisir manuellement les infos d’un animal.
// Prévu pour accueillir plus tard l’upload de documents avec OCR IA.
// Champs : nom, espèce, race, date de naissance, photo.
// L’animal est ensuite enregistré via AnimalService (Hive + Firebase).
// TODO: ajouter test

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

import '../models/animal_model.dart';
import '../services/animal_service.dart';

class AnimalFormScreen extends StatefulWidget {
  const AnimalFormScreen({super.key});

  @override
  State<AnimalFormScreen> createState() => _AnimalFormScreenState();
}

class _AnimalFormScreenState extends State<AnimalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _breedController = TextEditingController();
  DateTime? _birthDate;
  XFile? _image;

  final AnimalService _animalService = AnimalService();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() => _image = picked);
      }
    } catch (e) {
      assert(() {
        debugPrint("❌ Erreur sélection image : $e");
        return true;
      }());
    }
  }

  Future<void> _saveAnimal() async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _animalService.init();
      if (!mounted) return;

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final newAnimal = AnimalModel(
        id: const Uuid().v4(),
        name: _nameController.text.trim(),
        species: _speciesController.text.trim(),
        breed: _breedController.text.trim(),
        imageUrl: _image?.path ?? '',
        ownerId: userProvider.user?.id ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        birthDate: _birthDate,
      );

      final success = await _animalService.saveAnimal(newAnimal);

        if (success && mounted) {
          navigator.pop();
        } else {
          messenger.showSnackBar(
            const SnackBar(content: Text('Erreur lors de l\'enregistrement')),
          );
        }
    } catch (e) {
      debugPrint("❌ Erreur _saveAnimal : $e");
        messenger.showSnackBar(
          const SnackBar(content: Text('Une erreur est survenue')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un animal")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameController, "Nom de l’animal"),
              const SizedBox(height: 12),
              _buildTextField(_speciesController, "Espèce"),
              const SizedBox(height: 12),
              _buildTextField(_breedController, "Race"),
              const SizedBox(height: 12),
              _buildDatePicker(context),
              const SizedBox(height: 12),
              _buildPhotoPicker(),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.auto_fix_high),
                label: const Text("Pré-remplir via IA (à venir)"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEDE7F6),
                  foregroundColor: const Color(0xFF4B2991),
                ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Fonction OCR bientôt disponible...')),
                    );
                  },
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveAnimal();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B2991),
                ),
                label: const Text(
                  "Ajouter",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? "Ce champ est requis" : null,
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text("Date de naissance"),
      subtitle: Text(
        _birthDate != null
            ? "${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}"
            : "Non renseignée",
      ),
      trailing: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () async {
          final now = DateTime.now();
          final picked = await showDatePicker(
            context: context,
            initialDate: now,
            firstDate: DateTime(now.year - 30),
            lastDate: now,
          );
          if (picked != null) {
            setState(() => _birthDate = picked);
          }
        },
      ),
    );
  }

  Widget _buildPhotoPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Photo de l’animal"),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              image: _image != null
                  ? DecorationImage(
                      image: FileImage(File(_image!.path)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _image == null
                ? const Center(
                    child: Icon(Icons.add_a_photo, color: Colors.grey),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
