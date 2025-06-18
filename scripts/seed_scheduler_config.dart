// @dart=3.4
// Seed scheduler configuration in Firestore
// Usage: dart run scripts/seed_scheduler_config.dart

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../lib/firebase_options.dart';

Future<void> main() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final ref = FirebaseFirestore.instance.collection('config').doc('scheduler');
    await ref.set({
      'cleanupEnabled': true,
      'relaunchTime': '08:00',
      'updatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));

    stdout.writeln('✅ Scheduler configuration created.');
  } catch (e) {
    stderr.writeln('❌ Failed to seed scheduler config: $e');
    exit(1);
  }
}
