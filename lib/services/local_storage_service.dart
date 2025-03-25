import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';
import '../models/animal_model.dart';
import 'package:flutter/foundation.dart';

class LocalStorageService {
  static late Box<UserModel> _userBox;
  static late Box<AnimalModel> _animalBox;

  /// 📦 **Initialisation de Hive et des boîtes locales**
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(AnimalModelAdapter());

      _userBox = await Hive.openBox<UserModel>('users');
      _animalBox = await Hive.openBox<AnimalModel>('animals');

      debugPrint("✅ Hive local storage initialized!");
    } catch (e) {
      debugPrint("❌ Erreur lors de l'initialisation de Hive : $e");
    }
  }

  /// 💾 **Sauvegarder un utilisateur localement**
  static Future<void> saveUser(UserModel user) async {
    try {
      await _userBox.put(user.id, user);
      debugPrint("✅ Utilisateur sauvegardé localement : ${user.email}");
    } catch (e) {
      debugPrint("❌ Erreur lors de la sauvegarde de l'utilisateur : $e");
    }
  }

  /// 🔄 **Récupérer un utilisateur localement**
  static UserModel? getUser(String userId) {
    try {
      return _userBox.get(userId);
    } catch (e) {
      debugPrint("❌ Erreur lors de la récupération de l'utilisateur : $e");
      return null;
    }
  }

  /// 🐾 **Sauvegarder un animal localement**
  static Future<void> saveAnimal(AnimalModel animal) async {
    try {
      await _animalBox.put(animal.id, animal);
      debugPrint("✅ Animal sauvegardé localement : ${animal.name}");
    } catch (e) {
      debugPrint("❌ Erreur lors de la sauvegarde de l'animal : $e");
    }
  }

  /// 🔄 **Récupérer un animal localement**
  static AnimalModel? getAnimal(String animalId) {
    try {
      return _animalBox.get(animalId);
    } catch (e) {
      debugPrint("❌ Erreur lors de la récupération de l'animal : $e");
      return null;
    }
  }
}
