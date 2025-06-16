// Script Dart CLI pour vérifier et réparer automatiquement les collections Firestore d’AniSphère
// ⚠️ Ce script IGNORE les collections `users` et `animals` comme demandé
// À utiliser depuis `scripts/firestore_verification.dart`
// Exécution recommandée : `dart run scripts/firestore_verification.dart`

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:anisphere/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;

  final categories = ['sante', 'education', 'dressage', 'communaute'];

  // 1. Consentement RGPD global
  final consentDoc = firestore.collection('consents').doc('global');
  final consentSnap = await consentDoc.get();
  if (!consentSnap.exists) {
    await consentDoc.set({
      'current_version': 1,
      'last_update': Timestamp.now(),
      'description': 'Consentement RGPD pour synchronisation IA (anonymisée)',
      'required': true,
    });
    print('✅ Créé : consents/global');
  } else {
    print('🔹 Existe déjà : consents/global');
  }

  // 2. Superadmin → Flags d’activation IA cloud
  final flagsDoc = firestore.collection('superadmin').doc('flags');
  final flagsSnap = await flagsDoc.get();
  if (!flagsSnap.exists) {
    await flagsDoc.set({
      for (final c in categories) 'start_training_$c': false,
    });
    print('✅ Créé : superadmin/flags');
  } else {
    final updates = <String, dynamic>{};
    for (final c in categories) {
      final key = 'start_training_$c';
      if (!flagsSnap.data()!.containsKey(key)) updates[key] = false;
    }
    if (updates.isNotEmpty) {
      await flagsDoc.update(updates);
      print('✅ Champs ajoutés à superadmin/flags : $updates');
    } else {
      print('🔹 superadmin/flags à jour');
    }
  }

  // 3. Catégories IA (structure Firestore IA cloud)
  for (final cat in categories) {
    final catDoc = firestore.collection('ia_categories').doc(cat);
    final docSnap = await catDoc.get();
    if (!docSnap.exists) {
      await catDoc.set({'createdAt': Timestamp.now()});
      print('✅ Créé : ia_categories/$cat');
    }

    for (final sub in ['uploads', 'models', 'feedbacks']) {
      final subPath = catDoc.collection(sub).doc('init_check');
      if (!(await subPath.get()).exists) {
        await subPath.set({'createdAt': Timestamp.now()});
        print('✅ Créé : ia_categories/$cat/$sub/init_check');
      }
    }
  }

  // 4. Logs IA (pour chaque catégorie)
  for (final cat in categories) {
    final doc = firestore.collection('logs_ia').doc(cat);
    if (!(await doc.get()).exists) {
      await doc.set({'createdAt': Timestamp.now()});
      print('✅ Créé : logs_ia/$cat');
    }
  }

  print('\n✅ Firestore AniSphère — Vérification complète terminée (hors users & animals).');
}
