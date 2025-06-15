library;

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/security_settings_model.dart';
import 'package:anisphere/modules/noyau/services/modules_service.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometric = false;
  final List<String> _protected = [];
  Box<SecuritySettingsModel>? _box;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _box = await Hive.openBox<SecuritySettingsModel>('securitySettings');
    final settings = _box!.get('settings');
    setState(() {
      _biometric = settings?.biometricEnabled ?? false;
      _protected.clear();
      _protected.addAll(settings?.protectedModules ?? []);
    });
  }

  Future<void> _save() async {
    await _box!.put(
      'settings',
      SecuritySettingsModel(
        biometricEnabled: _biometric,
        encryptedPin: _box!.get('settings')?.encryptedPin,
        protectedModules: _protected,
      ),
    );
  }

  Future<void> _toggleBiometric(bool value) async {
    setState(() => _biometric = value);
    await _save();
  }

  Future<void> _toggleModule(String module, bool value) async {
    setState(() {
      if (value) {
        _protected.add(module);
      } else {
        _protected.remove(module);
      }
    });
    await _save();
  }

  Future<void> _setPin() async {
    await _box!.put(
      'settings',
      SecuritySettingsModel(
        biometricEnabled: _biometric,
        encryptedPin: '1234',
        protectedModules: _protected,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sécurité')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          SwitchListTile(
            value: _biometric,
            title: const Text('Authentification biométrique'),
            onChanged: _toggleBiometric,
          ),
          ListTile(
            leading: const Icon(Icons.pin),
            title: const Text('Définir un code PIN'),
            onTap: _setPin,
          ),
          const Divider(),
          const Text('Modules protégés'),
          ...ModulesService.modules.map(
            (m) => CheckboxListTile(
              title: Text(m.name),
              value: _protected.contains(m.id),
              onChanged: (v) => _toggleModule(m.id, v ?? false),
            ),
          ),
        ],
      ),
    );
  }
}
