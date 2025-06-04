library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/support_provider.dart';
import '../providers/user_provider.dart';
import '../models/support_model.dart';

class SupportAdminScreen extends StatefulWidget {
  const SupportAdminScreen({super.key});

  @override
  State<SupportAdminScreen> createState() => _SupportAdminScreenState();
}

class _SupportAdminScreenState extends State<SupportAdminScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SupportProvider>(context, listen: false).loadFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user?.role != 'super_admin') {
      return const Scaffold(
        body: Center(child: Text('🔒 Accès refusé')),
      );
    }

    final feedbacks = Provider.of<SupportProvider>(context).feedbacks;
    return Scaffold(
      appBar: AppBar(title: const Text('Feedbacks Utilisateur')),
      body: ListView.builder(
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          final SupportModel f = feedbacks[index];
          return ListTile(
            title: Text(f.message),
            subtitle: Text('${f.type} — ${f.status}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () =>
                  Provider.of<SupportProvider>(context, listen: false)
                      .deleteFeedback(f.id),
            ),
          );
        },
      ),
    );
  }
}