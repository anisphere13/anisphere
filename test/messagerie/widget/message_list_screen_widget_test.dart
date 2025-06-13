import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/messagerie/screens/message_list_screen.dart';
import 'package:anisphere/modules/messagerie/models/conversation_model.dart';
import 'package:anisphere/modules/messagerie/providers/messaging_provider.dart';
import 'package:anisphere/modules/messagerie/services/messaging_service.dart';
import '../../test_config.dart';

class _FakeService extends MessagingService {}

class _FakeProvider extends MessagingProvider {
  final List<ConversationModel> _list;
  _FakeProvider(this._list) : super(service: _FakeService());

  @override
  List<ConversationModel> get conversations => _list;
}

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('shows conversations grouped by module', (tester) async {
    final conv = ConversationModel(
      id: 'c1',
      participantIds: const ['u1', 'u2'],
      lastMessage: 'hi',
      moduleName: 'Demo',
    );
    final provider = _FakeProvider([conv]);

    await tester.pumpWidget(
      ChangeNotifierProvider<MessagingProvider>.value(
        value: provider,
        child: const MaterialApp(home: MessageListScreen()),
      ),
    );

    expect(find.text('Demo'), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });
}
