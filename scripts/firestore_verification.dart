// @dart=3.4
// 🔍 Script de vérification de la connexion Firestore
// Exécution : dart run scripts/firestore_verification.dart

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:anisphere/firebase_options.dart';

Future<void> main() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final snapshot = await FirebaseFirestore.instance
        .collection('verification')
        .limit(1)
        .get();

    stdout.writeln(
      '✅ Firestore accessible : ${snapshot.docs.length} document(s) trouvés',
    );
  } catch (e) {
    stderr.writeln('❌ Échec de la vérification Firestore : $e');
    exit(1);
  }
}
