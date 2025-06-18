// @dart=3.4
// 🗄️ Script de remplissage Firestore pour les collections principales
// Exécution : dart run scripts/seed_firestore.dart

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../lib/firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;

  await _seedSupport(firestore);
  await _seedMessages(firestore);
  await _seedSubscriptions(firestore);

  stdout.writeln('✅ Données de démonstration ajoutées.');
}

Future<void> _seedSupport(FirebaseFirestore firestore) async {
  await firestore.collection('support').add({
    'userId': 'demoUser',
    'type': 'bug',
    'message': 'Exemple de feedback.',
    'status': 'brouillon',
    'createdAt': Timestamp.now(),
    'updatedAt': Timestamp.now(),
  });
}

Future<void> _seedMessages(FirebaseFirestore firestore) async {
  final conv = await firestore.collection('messages').add({
    'participants': ['demoUser', 'admin'],
    'lastMessage': 'Hello',
    'updatedAt': Timestamp.now(),
  });

  await conv.collection('messages').add({
    'senderId': 'demoUser',
    'text': 'Hello',
    'sentAt': Timestamp.now(),
    'readBy': [],
  });
}

Future<void> _seedSubscriptions(FirebaseFirestore firestore) async {
  await firestore.collection('subscriptions').add({
    'userId': 'demoUser',
    'type': 'premium',
    'startDate': Timestamp.now(),
    'expiryDate': Timestamp.now(),
    'status': 'active',
    'lastSync': Timestamp.now(),
  });
}
