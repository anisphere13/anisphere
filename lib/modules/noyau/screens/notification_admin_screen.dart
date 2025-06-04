/// Copilot Prompt : NotificationAdminScreen permet au superadmin d'envoyer des notifications cloud manuelles.
/// Il peut choisir le titre, le message, la cible (tous, rôle, ID utilisateur), le module, et le type.
/// Intégré au noyau AniSphère, utilisé pour les communications importantes, marketing ou système.

library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/cloud_notification_service.dart';

class NotificationAdminScreen extends StatefulWidget {
  const NotificationAdminScreen({super.key});

  @override
  State<NotificationAdminScreen> createState() => _NotificationAdminScreenState();
}

class _NotificationAdminScreenState extends State<NotificationAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String body = "";
  String target = "all"; // all, role:educateur, user:<id>
  String module = "";
  String type = "info"; // info, alert, promo

  void _sendNotification() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final result = await CloudNotificationService.sendAdminNotification(
      title: title,
      body: body,
      target: target,
      module: module,
      type: type,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result ? "✅ Notification envoyée" : "❌ Échec de l'envoi")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    if (user?.role != "superadmin") {
      return const Scaffold(
        body: Center(child: Text("🔒 Accès refusé")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Envoi notification cloud")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Titre"),
                validator: (val) => val == null || val.isEmpty ? "Obligatoire" : null,
                onSaved: (val) => title = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Message"),
                maxLines: 4,
                validator: (val) => val == null || val.isEmpty ? "Obligatoire" : null,
                onSaved: (val) => body = val!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "Cible"),
                value: target,
                items: const [
                  DropdownMenuItem(value: "all", child: Text("Tous les utilisateurs")),
                  DropdownMenuItem(value: "role:educateur", child: Text("Rôle : éducateur")),
                  DropdownMenuItem(value: "role:pro", child: Text("Rôle : pro")),
                  DropdownMenuItem(value: "user:custom", child: Text("Utilisateur (ID manuel)")),
                ],
                onChanged: (val) => setState(() => target = val!),
              ),
              if (target == "user:custom")
                TextFormField(
                  decoration: const InputDecoration(labelText: "ID utilisateur"),
                  onSaved: (val) => target = "user:${val ?? ''}",
                ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Module concerné (facultatif)"),
                onSaved: (val) => module = val ?? "",
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "Type"),
                value: type,
                items: const [
                  DropdownMenuItem(value: "info", child: Text("Information")),
                  DropdownMenuItem(value: "alert", child: Text("Alerte")),
                  DropdownMenuItem(value: "promo", child: Text("Promotion")),
                ],
                onChanged: (val) => setState(() => type = val!),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text("Envoyer la notification"),
                onPressed: _sendNotification,
              )
            ],
          ),
        ),
      ),
    );
  }
}
