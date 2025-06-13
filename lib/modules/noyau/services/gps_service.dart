// Copilot Prompt : Service de localisation GPS pour AniSphère.
// Gère l'autorisation de localisation et le flux de positions en continu.
library;

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GpsService {
  StreamSubscription<Position>? _subscription;
  final StreamController<Position> _controller = StreamController.broadcast();

  /// Flux des positions GPS actuelles.
  Stream<Position> get positionStream => _controller.stream;

  Future<bool> _ensurePermission() async {
    // Copilot: vérifier et demander la permission GPS si besoin
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('❌ [GpsService] Permission localisation refusée');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      debugPrint('❌ [GpsService] Permission localisation refusée définitivement');
      return false;
    }
    return true;
  }

  Future<void> start() async {
    // Copilot: démarrer l'écoute de la localisation
    final hasPermission = await _ensurePermission();
    if (!hasPermission) return;
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('❌ [GpsService] Service localisation désactivé');
      return;
    }
    _subscription?.cancel();
    _subscription = Geolocator.getPositionStream().listen(
      (position) {
        _controller.add(position);
        debugPrint('📍 Position reçue: ${position.latitude}, ${position.longitude}');
      },
      onError: (e) {
        debugPrint('❌ [GpsService] Erreur flux localisation: $e');
      },
    );
  }

  Future<void> stop() async {
    // Copilot: arrêter l'écoute de la localisation
    await _subscription?.cancel();
    _subscription = null;
  }
}
