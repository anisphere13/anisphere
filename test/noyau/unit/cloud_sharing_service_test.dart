import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/noyau/services/cloud_sharing_service.dart';
import 'package:anisphere/modules/noyau/services/share_history_service.dart';
import 'package:anisphere/modules/noyau/models/share_history_model.dart';


class FakeHistoryService extends ShareHistoryService {
  final List<ShareHistoryModel> entries = [];

  @override
  Future<void> addEntry(ShareHistoryModel entry) async {
    entries.add(entry);
  }

  @override
  Future<List<ShareHistoryModel>> getEntries() async => entries;
}

void main() {
  test('share enregistre une entrée cloud', () async {
    final history = FakeHistoryService();
    final service = CloudSharingService(
      historyService: history,
    );

    await service.share('hello', cost: 2.5);

    expect(history.entries.length, 1);
    final entry = history.entries.first;
    expect(entry.mode, 'cloud');
    expect(entry.cost, 2.5);
    expect(entry.success, isTrue);
  });
}
