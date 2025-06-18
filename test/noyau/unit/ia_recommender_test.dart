import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/ia_recommendation/ia_recommender.dart';
import 'package:anisphere/modules/noyau/ia_recommendation/ia_local_engine.dart';
import 'package:anisphere/modules/noyau/ia_recommendation/ia_cloud_api.dart';
import 'package:anisphere/modules/noyau/ia_recommendation/recommendation_result.dart';
import 'package:anisphere/modules/noyau/models/animal_model.dart';
import 'package:anisphere/modules/noyau/services/device_sensors_service.dart';
import 'package:connectivity_plus_platform_interface/connectivity_plus_platform_interface.dart';
import 'package:mockito/mockito.dart';
import '../../test_config.dart';

class FakeLocalEngine extends IaLocalEngine {
  @override
  Future<RecommendationResult> recommend({
    required AnimalModel animal,
    Map<String, dynamic>? history,
  }) async {
    return const RecommendationResult(method: 'local');
  }
}

class FakeCloudApi extends IaCloudApi {
  @override
  Future<RecommendationResult> recommend({
    required AnimalModel animal,
    Map<String, dynamic>? history,
  }) async {
    return const RecommendationResult(method: 'cloud');
  }
}

class FakeSensors extends DeviceSensorsService {
  @override
  Future<List<ConnectivityResult>> getConnectivity() async =>
      [ConnectivityResult.wifi];
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('Recommender uses cloud when premium and online', () async {
    final recommender = IaRecommender(
      localEngine: FakeLocalEngine(),
      cloudApi: FakeCloudApi(),
      sensors: FakeSensors(),
    );
    final animal = AnimalModel(
      id: 'a1',
      name: 'Rex',
      species: 'dog',
      breed: 'labrador',
      imageUrl: '',
      ownerId: 'u1',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final res = await recommender.getRecommendation(
      animal: animal,
      userIsPremium: true,
    );
    expect(res.method, 'cloud');
  });
}
