// @dart=3.4
// 🔎 Script de vérification de l'initialisation Firestore pour AniSphère.
// Il contrôle que les collections et documents indispensables sont présents
// comme décrit dans docs/noyau_suivi.md.

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'package:anisphere/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final verifier = _FirestoreVerifier(FirebaseFirestore.instance);
  final success = await verifier.run();

  if (success) {
    stdout.writeln('🎉 Firestore correctement initialisé.');
  } else {
    stderr.writeln('❌ Firestore incomplet. Voir les erreurs ci-dessus.');
    exit(1);
  }
}

class _FirestoreVerifier {
  final FirebaseFirestore firestore;
  _FirestoreVerifier(this.firestore);

  Future<bool> run() async {
    var ok = true;
    if (!await _checkIaCategories()) ok = false;
    if (!await _checkLogs()) ok = false;
    if (!await _checkConsents()) ok = false;
    if (!await _checkSuperadmin()) ok = false;
    return ok;
  }

  Future<bool> _checkIaCategories() async {
    const cats = ['sante', 'education', 'dressage', 'communaute'];
    const subs = ['uploads', 'models', 'feedbacks'];
    var ok = true;

    for (final cat in cats) {
      final docRef = firestore.collection('ia_categories').doc(cat);
      final doc = await docRef.get();
      if (!doc.exists) {
        _ko('ia_categories/$cat manquant');
        ok = false;
        continue;
      }
      _ok('ia_categories/$cat');
      final collections = await docRef.listCollections();
      final names = {for (final c in collections) c.id};
      for (final sub in subs) {
        if (names.contains(sub)) {
          _ok('ia_categories/$cat/$sub');
        } else {
          _ko('ia_categories/$cat/$sub manquant');
          ok = false;
        }
      }
    }

    return ok;
  }

  Future<bool> _checkLogs() async {
    const cats = ['sante', 'education', 'dressage', 'communaute'];
    var ok = true;
    for (final cat in cats) {
      final doc = await firestore.collection('logs_ia').doc(cat).get();
      if (doc.exists) {
        _ok('logs_ia/$cat');
      } else {
        _ko('logs_ia/$cat manquant');
        ok = false;
      }
    }
    return ok;
  }

  Future<bool> _checkConsents() async {
    final doc = await firestore.collection('consents').doc('global').get();
    if (!doc.exists) {
      _ko('consents/global manquant');
      return false;
    }
    final data = doc.data() ?? <String, dynamic>{};
    var ok = true;

    if (data['current_version'] == 1) {
      _ok('consents/global.current_version');
    } else {
      _ko('consents/global.current_version');
      ok = false;
    }

    if (data.containsKey('last_update')) {
      _ok('consents/global.last_update');
    } else {
      _ko('consents/global.last_update');
      ok = false;
    }

    if (data['description'] is String) {
      _ok('consents/global.description');
    } else {
      _ko('consents/global.description');
      ok = false;
    }

    if (data['required'] == true) {
      _ok('consents/global.required');
    } else {
      _ko('consents/global.required');
      ok = false;
    }

    return ok;
  }

  Future<bool> _checkSuperadmin() async {
    final doc = await firestore.collection('superadmin').doc('flags').get();
    if (!doc.exists) {
      _ko('superadmin/flags manquant');
      return false;
    }
    final data = doc.data() ?? <String, dynamic>{};
    var ok = true;
    const fields = [
      'start_training_sante',
      'start_training_education',
      'start_training_dressage',
      'start_training_communaute',
    ];
    for (final f in fields) {
      if (data[f] == false) {
        _ok('superadmin/flags.$f');
      } else {
        _ko('superadmin/flags.$f');
        ok = false;
      }
    }
    return ok;
  }

  void _ok(String msg) => stdout.writeln('✅ $msg');
  void _ko(String msg) => stderr.writeln('❌ $msg');
}
