import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_functions_interop/firebase_functions_interop.dart' as fns;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/user_profile_model.dart';
import '../models/user_model.dart';
import 'user_service.dart';
import 'firebase_service.dart';

class ProValidationService {
  final UserService _userService;
  final FirebaseService _firebaseService;
  final fns.HttpsCallable? _storeSensitiveUserData;

  static const String _profileBox = 'user_profile_data';
  Box<UserProfileModel>? _box;

  ProValidationService({
    UserService? userService,
    FirebaseService? firebaseService,
    fns.HttpsCallable? storeSensitiveUserData,
    Box<UserProfileModel>? testBox,
  })  : _userService = userService ?? UserService(),
        _firebaseService = firebaseService ?? FirebaseService(),
        _storeSensitiveUserData = storeSensitiveUserData {
    if (testBox != null) {
      _box = testBox;
    }
  }

  Future<void> _initHive() async {
    if (_box != null) return;
    if (!Hive.isAdapterRegistered(52)) {
      Hive.registerAdapter(UserProfileModelAdapter());
    }
    _box = await Hive.openBox<UserProfileModel>(_profileBox);
  }

  Future<UserProfileModel?> getProfile() async {
    await _initHive();
    return _box?.get('profile');
  }

  Future<void> saveProfile(UserProfileModel profile) async {
    await _initHive();
    await _box?.put('profile', profile);
  }

  bool validateProfessionalData(UserProfileModel profile) {
    final requiredFilled =
        profile.phone.isNotEmpty && profile.address.isNotEmpty && profile.profession.isNotEmpty;
    final nigendOk = profile.nigend.isEmpty || RegExp(r'^[A-Z0-9]{5,}\\$').hasMatch(profile.nigend);
    return requiredFilled && nigendOk;
  }

  Future<bool> pairValidate(UserProfileModel profile, String validatorId) async {
    try {
      final doc = await _firebaseService.db.collection('users').doc(validatorId).get();
      return doc.exists;
    } catch (e) {
      debugPrint('❌ [ProValidation] pairValidate error: \$e');
      return false;
    }
  }

  Future<void> validateAndSync(UserProfileModel profile, {String? validatorId}) async {
    if (!validateProfessionalData(profile)) return;
    if (validatorId != null) {
      final ok = await pairValidate(profile, validatorId);
      if (!ok) return;
    }
    final validated = profile.copyWith(proValidated: true);
    await saveProfile(validated);
    if (_storeSensitiveUserData != null) {
      try {
        await _storeSensitiveUserData!.call(validated.toJson());
      } catch (e) {
        debugPrint('❌ [ProValidation] cloud function error: \$e');
      }
    }
  }
}
