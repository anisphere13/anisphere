/// 🧠 IAContextProvider — AniSphère
/// Fournit dynamiquement un IAContext à toute l’application.
/// Se base sur l’utilisateur, les animaux, la connectivité, la date de sync.
/// Prompt Copilot : "IAContextProvider builds and updates the IAContext for use across AniSphère"

library;

import 'package:flutter/foundation.dart';
import '../logic/ia_context.dart';
import '../services/local_storage_service.dart';
import '../services/animal_service.dart';
import '../services/user_service.dart';

class IAContextProvider extends ChangeNotifier {
  IAContext _context = IAContext.empty();

  IAContext get context => _context;

  /// 🔁 Initialisation complète du contexte IA
  Future<void> init({
    required bool isOffline,
    required AnimalService animalService,
    required UserService userService,
  }) async {
    try {
      final animals = await animalService.getAllAnimals();
      final bool isFirstLaunch =
          await LocalStorageService.getBool('firstLaunch', defaultValue: true);
      final DateTime? lastSync = await userService.getLastSyncDate();

      _context = IAContext(
        isOffline: isOffline,
        isFirstLaunch: isFirstLaunch,
        hasAnimals: animals.isNotEmpty,
        animalCount: animals.length,
        lastSyncDate: lastSync,
      );

      notifyListeners();

      debugPrint("✅ IAContextProvider initialisé : $_context");
    } catch (e) {
      debugPrint("❌ [IAContextProvider] Erreur init() : $e");
    }
  }

  /// 🔄 Mise à jour partielle du contexte IA
  void update({
    bool? isOffline,
    bool? isFirstLaunch,
    bool? hasAnimals,
    int? animalCount,
    DateTime? lastSyncDate,
  }) {
    _context = IAContext(
      isOffline: isOffline ?? _context.isOffline,
      isFirstLaunch: isFirstLaunch ?? _context.isFirstLaunch,
      hasAnimals: hasAnimals ?? _context.hasAnimals,
      animalCount: animalCount ?? _context.animalCount,
      lastSyncDate: lastSyncDate ?? _context.lastSyncDate,
    );
    notifyListeners();

    debugPrint("🔁 IAContextProvider mis à jour : $_context");
  }
}
