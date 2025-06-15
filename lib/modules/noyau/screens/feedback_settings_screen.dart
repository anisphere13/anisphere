// Copilot Prompt: "FeedbackSettingsScreen allows users to configure audio and haptic feedback for each module."
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/services/modules_service.dart';
import '../providers/feedback_options_provider.dart';

class FeedbackSettingsScreen extends StatefulWidget {
  const FeedbackSettingsScreen({super.key});

  @override
  State<FeedbackSettingsScreen> createState() => _FeedbackSettingsScreenState();
}

class _FeedbackSettingsScreenState extends State<FeedbackSettingsScreen> {
  late FeedbackOptionsProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<FeedbackOptionsProvider>(context, listen: false);
    _provider.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: Consumer<FeedbackOptionsProvider>(
        builder: (context, options, _) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            SwitchListTile(
              title: const Text('Activer le feedback'),
              value: options.enabled,
              onChanged: options.setEnabled,
            ),
            ListTile(
              title: const Text('Volume'),
              subtitle: Slider(
                value: options.volume,
                onChanged: options.enabled ? options.setVolume : null,
              ),
            ),
            ListTile(
              title: const Text('Intensité haptique'),
              subtitle: Slider(
                value: options.intensity,
                onChanged: options.enabled ? options.setIntensity : null,
              ),
            ),
            const Divider(),
            const Text('Modules',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...ModulesService.modules.map(
              (m) => CheckboxListTile(
                title: Text(m.name),
                value: options.moduleToggles[m.id] ?? true,
                onChanged: (v) => options.toggleModule(m.id, v ?? true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
