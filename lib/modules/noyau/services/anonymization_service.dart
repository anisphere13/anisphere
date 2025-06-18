
import 'dart:convert';
import 'package:crypto/crypto.dart';

import '../models/user_model.dart';
import '../models/animal_model.dart';
import '../models/photo_model.dart';

/// Service d'anonymisation des données.
/// Hache ou retire les identifiants personnels avant envoi cloud.
class AnonymizationService {
  const AnonymizationService();

  static String _hash(String input) {
    if (input.isEmpty) return '';
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }

  /// Retourne une copie anonymisée de l'utilisateur.
  UserModel anonymizeUser(UserModel user) {
    return user.copyWith(
      id: _hash(user.id),
      name: _hash(user.name),
      email: _hash(user.email),
      phone: _hash(user.phone),
      profilePicture: '',
    );
  }

  /// Retourne une copie anonymisée de l'animal.
  AnimalModel anonymizeAnimal(AnimalModel animal) {
    return animal.copyWith(
      id: _hash(animal.id),
      name: _hash(animal.name),
      ownerId: _hash(animal.ownerId),
    );
  }

  /// Copie anonymisée de la photo.
  PhotoModel anonymizePhoto(PhotoModel photo) {
    return photo.copyWith(
      id: _hash(photo.id),
      userId: _hash(photo.userId),
      animalId: _hash(photo.animalId),
    );
  }

  /// Anonymise certaines clefs dans la map.
  Map<String, dynamic> anonymizeMap(
    Map<String, dynamic> data,
    List<String> keys,
  ) {
    final result = Map<String, dynamic>.from(data);
    for (final key in keys) {
      if (!result.containsKey(key)) continue;
      final value = result[key];
      if (value is String) {
        result[key] = _hash(value);
      } else {
        result.remove(key);
      }
    }
    return result;
  }
}
