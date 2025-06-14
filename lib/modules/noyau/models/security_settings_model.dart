library;

import 'package:hive/hive.dart';

part 'security_settings_model.g.dart';

@HiveType(typeId: 70)
class SecuritySettingsModel {
  @HiveField(0)
  final bool biometricEnabled;

  @HiveField(1)
  final String? encryptedPin;

  @HiveField(2)
  final List<String> protectedModules;

  const SecuritySettingsModel({
    required this.biometricEnabled,
    this.encryptedPin,
    this.protectedModules = const [],
  });
}
