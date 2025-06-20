// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show
        defaultTargetPlatform,
        kIsWeb,
        TargetPlatform; // Added missing semicolon

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        return linux;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for this platform. '
          'You can reconfigure this by running the FlutterFire CLI again.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7hNigL31teKjIxK8GajpDHK9JEFUsd-Y',
    appId: '1:1094148577193:web:5891f660662d5456a9d6b8',
    messagingSenderId: '1094148577193',
    projectId: 'anisphere-27f83',
    authDomain: 'anisphere-27f83.firebaseapp.com',
    storageBucket: 'anisphere-27f83.appspot.com',
    measurementId: 'G-KN9NHEVBN8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmQ4HV6sGCXgQr5RkKjkI93ObMfMTxWms',
    appId: '1:1094148577193:android:527b282048b8bcf9a9d6b8',
    messagingSenderId: '1094148577193',
    projectId: 'anisphere-27f83',
    storageBucket: 'anisphere-27f83.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBoEyErRZH8Ya9zsDw2PAi_tzbReWJgwDw',
    appId: '1:1094148577193:ios:df07801c555ec094a9d6b8',
    messagingSenderId: '1094148577193',
    projectId: 'anisphere-27f83',
    storageBucket: 'anisphere-27f83.appspot.com',
    iosClientId: '1094148577193-7v1lj0ieskkl8han4va7hitk76c6a0b5.apps.googleusercontent.com',
    iosBundleId: 'com.example.anisphere',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBoEyErRZH8Ya9zsDw2PAi_tzbReWJgwDw',
    appId: '1:1094148577193:ios:df07801c555ec094a9d6b8',
    messagingSenderId: '1094148577193',
    projectId: 'anisphere-27f83',
    storageBucket: 'anisphere-27f83.appspot.com',
    iosClientId: '1094148577193-7v1lj0ieskkl8han4va7hitk76c6a0b5.apps.googleusercontent.com',
    iosBundleId: 'com.example.anisphere',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7hNigL31teKjIxK8GajpDHK9JEFUsd-Y',
    appId: '1:1094148577193:web:fbb4b3d2f676e683a9d6b8',
    messagingSenderId: '1094148577193',
    projectId: 'anisphere-27f83',
    authDomain: 'anisphere-27f83.firebaseapp.com',
    storageBucket: 'anisphere-27f83.appspot.com',
    measurementId: 'G-KZWPM3FN9Z',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: 'AIzaSyDmQ4HV6sGCXgQr5RkKjkI93ObMfMTxWms',
    appId: '1:1094148577193:android:527b282048b8bcf9a9d6b8',
    messagingSenderId: '1094148577193',
    projectId: 'anisphere-27f83',
    storageBucket: 'anisphere-27f83.appspot.com',
  );
}