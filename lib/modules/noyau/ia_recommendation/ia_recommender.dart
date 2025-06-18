import 'package:connectivity_plus/connectivity_plus.dart';

import '../models/animal_model.dart';
import '../services/device_sensors_service.dart';
import 'recommendation_result.dart';
import 'ia_cloud_api.dart';
import 'ia_local_engine.dart';

/// High level recommender switching between local and cloud models.
class IaRecommender {
  final IaLocalEngine localEngine;
  final IaCloudApi cloudApi;
  final DeviceSensorsService sensors;

  IaRecommender({
    IaLocalEngine? localEngine,
    IaCloudApi? cloudApi,
    DeviceSensorsService? sensors,
  })  : localEngine = localEngine ?? IaLocalEngine(),
        cloudApi = cloudApi ?? IaCloudApi(),
        sensors = sensors ?? DeviceSensorsService();

  Future<RecommendationResult> getRecommendation({
    required AnimalModel animal,
    Map<String, dynamic>? history,
    required bool userIsPremium,
  }) async {
    final connectivity = await sensors.getConnectivity();
    final online = !connectivity.contains(ConnectivityResult.none);
    if (userIsPremium && online) {
      final res = await cloudApi.recommend(animal: animal, history: history);
      if (res.method != 'cloud_fallback') return res;
    }
    return localEngine.recommend(animal: animal, history: history);
  }
}
