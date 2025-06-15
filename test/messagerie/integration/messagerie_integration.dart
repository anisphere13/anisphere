import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anisphere/modules/messagerie/screens/chat_screen.dart';
import 'package:anisphere/modules/messagerie/models/conversation_model.dart';
import 'package:anisphere/modules/messagerie/providers/messaging_provider.dart';
import 'package:anisphere/modules/messagerie/services/messaging_service.dart';
import 'package:anisphere/modules/messagerie/models/message_model.dart';
import 'package:anisphere/modules/noyau/providers/user_provider.dart';
import 'package:anisphere/modules/noyau/models/user_model.dart';
import 'package:anisphere/modules/noyau/services/user_service.dart';
import 'package:anisphere/modules/noyau/services/auth_service.dart';
import '../test_config.dart';

class _FakeService extends MessagingService {
  final List<MessageModel> sent = [];
  _FakeService();

  @override
  Future<void> sendMessage(MessageModel message) async {
    sent.add(message.copyWith(sent: true));
  }

  @override
  Future<List<MessageModel>> getMessages(String conversationId) async {
    return sent.where((m) => m.conversationId == conversationId).toList();
  }
}

class _TestUserProvider extends UserProvider {
  final UserModel _user;
  _TestUserProvider(this._user)
      : super(UserService(skipHiveInit: true), AuthService());

  @override
  UserModel? get user => _user;
}

void main() {
  testWidgets('send message through chat flow', (tester) async {
    await initTestEnv();

    final service = _FakeService();
    final messagingProvider = MessagingProvider(service: service);
    final userProvider = _TestUserProvider(
      const UserModel(
        id: 'u1',
        name: 'Test',
        email: 't@test.com',
        phone: '',
        profilePicture: '',
        profession: '',
        ownedSpecies: {},
        ownedAnimals: [],
        preferences: {},
        moduleRoles: {},
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
        activeModules: [],
        role: 'user',
        iaPremium: false,
      ),
    );
    final conv = ConversationModel(id: 'c1', moduleName: 'demo');

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<MessagingProvider>.value(value: messagingProvider),
          ChangeNotifierProvider<UserProvider>.value(value: userProvider),
        ],
        child: MaterialApp(home: ChatScreen(conversation: conv)),
      ),
    );

    await tester.enterText(find.byType(TextField), 'hello');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    expect(find.text('hello'), findsOneWidget);
  });
}
