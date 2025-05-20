/// Copilot Prompt : Service de stockage Hive local pour AniSphère.
/// Gère deux boîtes : utilisateurs et animaux.
/// Fournit des fonctions de lecture/écriture bas niveau.
/// Utilisé en complément de UserService et AnimalService.
/// Peut être utilisé aussi pour debug offline.
library;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../models/animal_model.dart';

class LocalStorageService {
  static late Box<UserModel> _userBox;
  static late Box<AnimalModel> _animalBox;
  static late Box _settingsBox;

  /// 📦 Initialisation Hive
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(AnimalModelAdapter());
      _userBox = await Hive.openBox<UserModel>('users');
      _animalBox = await Hive.openBox<AnimalModel>('animals');
      _settingsBox = await Hive.openBox('settings');
      debugPrint("✅ Hive local storage initialized!");
    } catch (e) {
      debugPrint("❌ Erreur init Hive : $e");
    }
  }

  /// 💾 Sauvegarder un utilisateur
  static Future<void> saveUser(UserModel user) async {
    try {
      await _userBox.put(user.id, user);
      debugPrint("✅ Utilisateur sauvegardé localement : ${user.email}");
    } catch (e) {
      debugPrint("❌ Erreur saveUser : $e");
    }
  }

  /// 🔄 Lire un utilisateur
  static UserModel? getUser(String userId) {
    try {
      return _userBox.get(userId);
    } catch (e) {
      debugPrint("❌ Erreur getUser : $e");
      return null;
    }
  }

  /// 💾 Sauvegarder un animal
  static Future<void> saveAnimal(AnimalModel animal) async {
    try {
      await _animalBox.put(animal.id, animal);
      debugPrint("✅ Animal sauvegardé localement : ${animal.name}");
    } catch (e) {
      debugPrint("❌ Erreur saveAnimal : $e");
    }
  }

  /// 🔄 Lire un animal
  static AnimalModel? getAnimal(String animalId) {
    try {
      return _animalBox.get(animalId);
    } catch (e) {
      debugPrint("❌ Erreur getAnimal : $e");
      return null;
    }
  }

  /// 🔧 Méthodes génériques pour IA maîtresse ou paramètres globaux
  static dynamic get(String key, {dynamic defaultValue}) {
    try {
      return _settingsBox.get(key, defaultValue: defaultValue);
    } catch (e) {
      debugPrint("❌ Erreur get (settings) : $e");
      return defaultValue;
    }
  }

  static Future<void> set(String key, dynamic value) async {
    try {
      await _settingsBox.put(key, value);
    } catch (e) {
      debugPrint("❌ Erreur set (settings) : $e");
    }
  }

  static Future<void> remove(String key) async {
    try {
      await _settingsBox.delete(key);
    } catch (e) {
      debugPrint("❌ Erreur remove (settings) : $e");
    }
  }
}
