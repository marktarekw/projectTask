// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDYxekjh7enFt7RPldPAXslpHxlsa3ufVk',
    appId: '1:871985029768:web:90d62cf30e9ce3de34353d',
    messagingSenderId: '871985029768',
    projectId: 'task-management-app-85db8',
    authDomain: 'task-management-app-85db8.firebaseapp.com',
    storageBucket: 'task-management-app-85db8.appspot.com',
    measurementId: 'G-10GVWD9RS8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzr6LU3-QDhEHDLLvWAMFDOcpswkLCm2g',
    appId: '1:871985029768:android:d829fed1a7302e5134353d',
    messagingSenderId: '871985029768',
    projectId: 'task-management-app-85db8',
    storageBucket: 'task-management-app-85db8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrMkCC9d_f7Ow62K_s9dw88uCfS2uaNuo',
    appId: '1:871985029768:ios:f0f88fd3a94c822034353d',
    messagingSenderId: '871985029768',
    projectId: 'task-management-app-85db8',
    storageBucket: 'task-management-app-85db8.appspot.com',
    iosBundleId: 'com.example.projectTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrMkCC9d_f7Ow62K_s9dw88uCfS2uaNuo',
    appId: '1:871985029768:ios:33d00e2edd169dbb34353d',
    messagingSenderId: '871985029768',
    projectId: 'task-management-app-85db8',
    storageBucket: 'task-management-app-85db8.appspot.com',
    iosBundleId: 'com.example.projectTask.RunnerTests',
  );
}