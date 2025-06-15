library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/conversation_model.dart';
import '../providers/messaging_provider.dart';
import 'chat_screen.dart';

class MessageListScreen extends StatefulWidget {
  const MessageListScreen({super.key});

  @override
  State<MessageListScreen> createState() => _MessageListScreenState();
}

class _MessageListScreenState extends State<MessageListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MessagingProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MessagingProvider>(context);
    final grouped = <String, List<ConversationModel>>{};
    for (final conv in provider.conversations) {
      grouped.putIfAbsent(conv.moduleName, () => []).add(conv);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Messagerie')),
      body: ListView(
        children: grouped.entries.expand((entry) {
          final module = entry.key;
          final convs = entry.value;
          return [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                module,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ...convs.map(
              (c) => ListTile(
                title: Text(c.participantIds.join(', ')),
                subtitle: Text(c.lastMessage),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(conversation: c),
                    ),
                  );
                },
              ),
            ),
          ];
        }).toList(),
      ),
    );
  }
}
