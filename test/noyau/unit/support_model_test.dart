// Copilot Prompt : Test automatique généré pour support_model.dart (unit)
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:anisphere/modules/noyau/models/support_ticket_model.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });
  test('toJson and fromJson preserve fields', () {
    final ticket = SupportTicketModel(
      id: '1',
      userId: 'u',
      type: SupportTicketType.bug,
      message: 'm',
      createdAt: DateTime(2024, 1, 1),
      updatedAt: DateTime(2024, 1, 2),
    );
    final map = ticket.toJson();
    final copy = SupportTicketModel.fromJson(map);
    expect(copy.id, '1');
    expect(copy.type, SupportTicketType.bug);
  });
}
