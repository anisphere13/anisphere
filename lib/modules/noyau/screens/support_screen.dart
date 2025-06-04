library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/support_provider.dart';
import '../providers/user_provider.dart';
import '../models/support_model.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final _messageController = TextEditingController();
  String _type = 'bug';
  bool _isSending = false;

  Future<void> _send() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user == null) return;
    setState(() => _isSending = true);
    final feedback = SupportModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: user.id,
      type: _type,
      message: _messageController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await Provider.of<SupportProvider>(context, listen: false)
        .addFeedback(feedback);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _type,
              items: const [
                DropdownMenuItem(value: 'bug', child: Text('Bug')),
                DropdownMenuItem(value: 'idee', child: Text('Idée')),
                DropdownMenuItem(value: 'contact', child: Text('Contact')),
              ],
              onChanged: (v) => setState(() => _type = v ?? 'bug'),
              decoration: const InputDecoration(labelText: 'Type de message'),
            ),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSending ? null : _send,
              child: const Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}