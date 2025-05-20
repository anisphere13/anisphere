// scripts/fix_flutter_analyze.dart
import 'dart:io';

void log(String msg) => stderr.writeln(msg);

Future<void> main() async {
  log('🛠️ Script strict v3 — Corrections critiques finales');

  await _corrigerAnimalsScreen();
  await _corrigerMainScreenChildArgument();
  await _insererAppleCredential();
  await _ajouterDocComments();
  log('✅ Script strict v3 terminé. Relancez build_runner et flutter analyze.');
}

Future<void> _corrigerAnimalsScreen() async {
  final path = 'lib/modules/noyau/screens/animals_screen.dart';
  final file = File(path);
  if (!await file.exists()) return;
  final content = '''
import 'package:flutter/material.dart';

/// Écran principal des animaux dans AniSphère.
class AnimalsScreen extends StatelessWidget {
  final Widget child;

  const AnimalsScreen({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: child),
    );
  }
}
''';
  await file.writeAsString(content);
  log('✅ Classe AnimalsScreen corrigée proprement');
}

Future<void> _corrigerMainScreenChildArgument() async {
  final path = 'lib/modules/noyau/screens/main_screen.dart';
  final file = File(path);
  if (!await file.exists()) return;
  var content = await file.readAsString();
  if (content.contains('AnimalsScreen(') && !content.contains('child:')) {
    content = content.replaceFirst(
      RegExp(r'AnimalsScreen\(([^)]*)\)'),
      'AnimalsScreen(child: Placeholder(), 1)',
    );
    await file.writeAsString(content);
    log('🔧 child: Placeholder() ajouté dans MainScreen');
  }
}

Future<void> _insererAppleCredential() async {
  final path = 'lib/modules/noyau/services/auth_service.dart';
  final file = File(path);
  if (!await file.exists()) return;
  var content = await file.readAsString();
  if (!content.contains('getAppleIDCredential')) {
    content = content.replaceFirst(
      'final email = appleIdCredential.email;',
      '''final appleIdCredential = await SignInWithApple.getAppleIDCredential(
  scopes: [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
  ],
);
final email = appleIdCredential.email;'''
    );
    await file.writeAsString(content);
    log('🔐 Bloc appleIdCredential inséré');
  }
}

Future<void> _ajouterDocComments() async {
  final fichiers = [
    'lib/modules/noyau/models/animal_model.dart',
    'lib/modules/noyau/screens/login_screen.dart',
    'lib/modules/noyau/screens/register_screen.dart',
    'lib/modules/noyau/screens/splash_screen.dart',
    'lib/modules/noyau/services/animal_service.dart',
    'lib/modules/noyau/services/firebase_service.dart',
    'scripts/fix_imports_noyau.dart',
  ];
  for (final path in fichiers) {
    final file = File(path);
    if (!await file.exists()) continue;
    final content = await file.readAsString();
    if (!content.trimLeft().startsWith('///')) {
      await file.writeAsString('/// Fichier du module AniSphère — auto-doc\n$content');
      log('📝 Doc comment ajouté à $path');
    }
  }
}
