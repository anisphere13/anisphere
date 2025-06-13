// Copilot: Exemple d'utilisation
library;

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Provider GPS pour AniSphère.
/// Expose la position courante via un stream et l'état de connexion réseau.
class GpsProvider with ChangeNotifier {
  final Connectivity _connectivity;
  Stream<Position> _positionStream = const Stream.empty();
  bool _isConnected = false;

  /// Flux de position courante.
  Stream<Position> get positionStream => _positionStream;

  /// Indique si une connexion réseau est active.
  bool get isConnected => _isConnected;

  GpsProvider({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  /// Initialisation du flux de position et de l'écoute réseau.
  Future<void> init() async {
    _positionStream = Geolocator.getPositionStream();
    final connectivity = await _connectivity.checkConnectivity();
    _updateConnection(connectivity);
    _connectivity.onConnectivityChanged.listen(_updateConnection);
  }

  void _updateConnection(ConnectivityResult result) {
    final connected = result != ConnectivityResult.none;
    if (connected != _isConnected) {
      _isConnected = connected;
      notifyListeners();
    }
  }
}

