/// Copilot Prompt : Service de stockage Hive local pour AniSphère.
/// Gère deux boîtes : utilisateurs et animaux.
/// Fournit des fonctions de lecture/écriture bas niveau.
/// Utilisé en complément de UserService et AnimalService.
/// Peut être utilisé aussi pour debug offline.
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';
import '../models/animal_model.dart';
class LocalStorageService {
  static late Box<UserModel> _userBox;
  static late Box<AnimalModel> _animalBox;
  /// 📦 Initialisation Hive
  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      Hive.registerAdapter(UserModelAdapter());
      Hive.registerAdapter(AnimalModelAdapter());
      _userBox = await Hive.openBox<UserModel>('users');
      _animalBox = await Hive.openBox<AnimalModel>('animals');
      debugPrint("✅ Hive local storage initialized!");
    } catch (e) {
      debugPrint("❌ Erreur init Hive : $e");
    }
  }
  /// 💾 Sauvegarder un utilisateur
  static Future<void> saveUser(UserModel user) async {
      await _userBox.put(user.id, user);
      debugPrint("✅ Utilisateur sauvegardé localement : ${user.email}");
      debugPrint("❌ Erreur saveUser : $e");
  /// 🔄 Lire un utilisateur
  static UserModel? getUser(String userId) {
      return _userBox.get(userId);
      debugPrint("❌ Erreur getUser : $e");
      return null;
  /// 💾 Sauvegarder un animal
  static Future<void> saveAnimal(AnimalModel animal) async {
      await _animalBox.put(animal.id, animal);
      debugPrint("✅ Animal sauvegardé localement : ${animal.name}");
      debugPrint("❌ Erreur saveAnimal : $e");
  /// 🔄 Lire un animal
  static AnimalModel? getAnimal(String animalId) {
      return _animalBox.get(animalId);
      debugPrint("❌ Erreur getAnimal : $e");
}
/// 🔧 Ajout automatique des méthodes get/set/remove pour tests IA maîtresse
  static final _box = Hive.box('settings');
  static dynamic get(String key, {dynamic defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  static Future<void> set(String key, dynamic value) async {
    await _box.put(key, value);
  static Future<void> remove(String key) async {
    await _box.delete(key);
