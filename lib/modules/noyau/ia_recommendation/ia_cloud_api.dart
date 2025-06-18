import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/animal_model.dart';
import 'feature_builder.dart';
import 'recommendation_result.dart';

/// API client for cloud based recommendations.
class IaCloudApi {
  final http.Client httpClient;
  static const String _baseUrl =
      'https://REGION-PROJECT.cloudfunctions.net/iaRecommendation';

  IaCloudApi({http.Client? client}) : httpClient = client ?? http.Client();

  Future<RecommendationResult> recommend({
    required AnimalModel animal,
    Map<String, dynamic>? history,
  }) async {
    final features = FeatureBuilder.build(animal: animal, history: history);
    final uri = Uri.parse('$_baseUrl/recommend');
    try {
      final res = await httpClient.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'features': features}),
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        return RecommendationResult(
          method: data['method'] ?? 'cloud',
          idealDuration: data['duration'] != null
              ? Duration(minutes: data['duration'])
              : null,
          difficulty: data['difficulty'] ?? 'medium',
          successProbability:
              (data['success'] as num?)?.toDouble() ?? 0.5,
          note: data['note'] as String?,
        );
      }
      throw HttpException('status ${res.statusCode}');
    } catch (_) {
      return const RecommendationResult(method: 'cloud_fallback');
    }
  }
}
