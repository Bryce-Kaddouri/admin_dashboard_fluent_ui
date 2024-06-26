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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBFqSEK3RBX42h3pT49WPJIf0TtaQKJ95Q',
    appId: '1:825112518692:web:fb6b2880e4950180d578b1',
    messagingSenderId: '825112518692',
    projectId: 'admin-dashboard-app-2024',
    authDomain: 'admin-dashboard-app-2024.firebaseapp.com',
    storageBucket: 'admin-dashboard-app-2024.appspot.com',
    measurementId: 'G-ZK5GVYVDB9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_4a2eTZAJ7nL25BUiKdO-IgCDJMxFxus',
    appId: '1:825112518692:android:9cc1a8c4b32e023dd578b1',
    messagingSenderId: '825112518692',
    projectId: 'admin-dashboard-app-2024',
    storageBucket: 'admin-dashboard-app-2024.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGwRM4gZppeYFHPP96hfbj4HZvRd3MbaE',
    appId: '1:825112518692:ios:cb9c4d04a646bfcbd578b1',
    messagingSenderId: '825112518692',
    projectId: 'admin-dashboard-app-2024',
    storageBucket: 'admin-dashboard-app-2024.appspot.com',
    iosBundleId: 'com.example.adminDashboard',
  );
}
