// scripts/fix_flutter_analyze.dart
import 'dart:io';

void log(String message) {
  stderr.writeln(message); // Utilisé pour éviter les print en production
}

void main() async {
  log('🚀 Correction automatique des erreurs flutter analyze...');

  // 1. Ajout des doc-comments manquants
  final docCommentFixes = {
    'lib/modules/noyau/models/user_model.dart':
        '/// Modèle de données utilisateur pour AniSphère.\n',
    'lib/modules/noyau/providers/user_provider.dart':
        '/// Provider de l’utilisateur courant dans AniSphère.\n',
    'lib/modules/noyau/services/auth_service.dart':
        '/// Service d’authentification utilisateur (email, Google, Apple).\n',
    'lib/modules/noyau/services/user_service.dart':
        '/// Service de gestion utilisateur (Hive/Firebase).\n',
    'lib/services/app_initializer.dart':
        '/// Initialise AniSphère (Hive, Firebase, UX, IA).\n',
  };

  for (final entry in docCommentFixes.entries) {
    final file = File(entry.key);
    if (await file.exists()) {
      final content = await file.readAsString();
      if (!content.trimLeft().startsWith('///')) {
        await file.writeAsString(entry.value + content);
        log('✅ Doc ajoutée dans ${entry.key}');
      }
    }
  }

  // 2. Correction des tests de type dans user_provider.dart
  await _replaceInFile(
    'lib/modules/noyau/providers/user_provider.dart',
    "ConnectivityResult.wifi == result",
    "[ConnectivityResult.wifi].contains(result)",
  );
  await _replaceInFile(
    'lib/modules/noyau/providers/user_provider.dart',
    "ConnectivityResult.mobile == result",
    "[ConnectivityResult.mobile].contains(result)",
  );

  // 3. Ajout explicite de appleIdCredential si non défini
  final authFile = File('lib/modules/noyau/services/auth_service.dart');
  if (await authFile.exists()) {
    var content = await authFile.readAsString();

    final pattern = RegExp(r"final\s+email\s*=\s*appleIdCredential\.email;");
    if (pattern.hasMatch(content) && !content.contains('getAppleIDCredential')) {
      content = content.replaceFirst(
        pattern,
        '''
final appleIdCredential = await SignInWithApple.getAppleIDCredential(
  scopes: [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
  ],
);
final email = appleIdCredential.email;
''',
      );

      content = content.replaceAll(
        'final displayName = appleIdCredential.givenName;',
        'final displayName = appleIdCredential.givenName ?? \'Utilisateur Apple\';',
      );

      await authFile.writeAsString(content);
      log('🆕 appleIdCredential ajouté dans auth_service.dart');
    }
  }

  // 4. Nettoyage des imports inutiles
  await _removeLineContaining(
    'test/noyau/unit/auth_provider_test.dart',
    "auth_service.dart",
  );

  // 5. Suppression des duplicate_ignore
  await _removeDuplicateIgnores('test/noyau/unit/auth_provider_test.mocks.dart');
  await _removeDuplicateIgnores('test/noyau/unit/firebase_service_test_config.mocks.dart');

  log('🎉 Toutes les corrections flutter analyze sont terminées.');
}

Future<void> _replaceInFile(String path, String from, String to) async {
  final file = File(path);
  if (await file.exists()) {
    final content = await file.readAsString();
    final replaced = content.replaceAll(from, to);
    if (replaced != content) {
      await file.writeAsString(replaced);
      log('🔧 Remplacement effectué dans $path');
    }
  }
}

Future<void> _removeLineContaining(String path, String search) async {
  final file = File(path);
  if (await file.exists()) {
    final lines = await file.readAsLines();
    final filtered = lines.where((line) => !line.contains(search)).toList();
    await file.writeAsString(filtered.join('\n'));
    log('🧹 Ligne contenant "$search" supprimée de $path');
  }
}

Future<void> _removeDuplicateIgnores(String path) async {
  final file = File(path);
  if (await file.exists()) {
    final lines = await file.readAsLines();
    final result = <String>[];
    final seen = <String>{};

    for (final line in lines) {
      if (line.trim().startsWith('// ignore:')) {
        if (seen.contains(line)) continue;
        seen.add(line);
      }
      result.add(line);
    }

    await file.writeAsString(result.join('\n'));
    log('🧼 duplicate_ignore nettoyés dans $path');
  }
}
