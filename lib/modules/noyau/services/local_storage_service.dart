// Copilot Prompt : Service de stockage Hive local pour AniSphère.
// Gère deux boîtes : utilisateurs et animaux.
// Fournit des fonctions de lecture/écriture bas niveau.
// Utilisé en complément de UserService et AnimalService.
// Peut être utilisé aussi pour debug offline.
library;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import '../models/user_model.dart';
import '../models/animal_model.dart';
import '../models/job_model.dart';

class LocalStorageService {
  static late Box<UserModel> _userBox;
  static late Box<AnimalModel> _animalBox;
  static late Box _settingsBox;
  static const _secureKeyName = 'hive_aes_key';
  static const _secureStorage = FlutterSecureStorage();
  static HiveAesCipher? _cipher;

  static Future<HiveAesCipher> _getCipher() async {
    if (_cipher != null) return _cipher!;
    final stored = await _secureStorage.read(key: _secureKeyName);
    List<int> key;
    if (stored == null) {
      key = Hive.generateSecureKey();
      await _secureStorage.write(key: _secureKeyName, value: base64UrlEncode(key));
    } else {
      key = base64Url.decode(stored);
    }
    _cipher = HiveAesCipher(key);
    return _cipher!;
  }

  /// 📦 Initialisation Hive
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      final cipher = await _getCipher();
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(AnimalModelAdapter());
      Hive.registerAdapter(JobModelAdapter());
      _userBox = await Hive.openBox<UserModel>('users', encryptionCipher: cipher);
      _animalBox = await Hive.openBox<AnimalModel>('animals', encryptionCipher: cipher);
      _settingsBox = await Hive.openBox('settings', encryptionCipher: cipher);
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

  /// ✅ Helper : lecture booléenne avec fallback
  static Future<bool> getBool(String key, {bool defaultValue = false}) async {
    try {
      final value = _settingsBox.get(key);
      return value is bool ? value : defaultValue;
    } catch (e) {
      debugPrint("❌ Erreur getBool : $e");
      return defaultValue;
    }
  }
}
