// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDmYnWl-VessOmaayB-b34hpbp_c3hY_gw',
    appId: '1:644663398536:web:1a1c1a91d1d9d2a73c0f3d',
    messagingSenderId: '644663398536',
    projectId: 'foodanddrink-a3b0a',
    authDomain: 'foodanddrink-a3b0a.firebaseapp.com',
    storageBucket: 'foodanddrink-a3b0a.appspot.com',
    measurementId: 'G-YLPFYNDYLT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjF3NRoW2ujn5TieEO-uAutmXMdWJzl5s',
    appId: '1:644663398536:android:4cc91c896a3a6ea73c0f3d',
    messagingSenderId: '644663398536',
    projectId: 'foodanddrink-a3b0a',
    storageBucket: 'foodanddrink-a3b0a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4kiI37aT76sG39zB9yMzAN8A5s47L7y8',
    appId: '1:644663398536:ios:1de85880a155665e3c0f3d',
    messagingSenderId: '644663398536',
    projectId: 'foodanddrink-a3b0a',
    storageBucket: 'foodanddrink-a3b0a.appspot.com',
    iosBundleId: 'com.example.foodAndDrink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4kiI37aT76sG39zB9yMzAN8A5s47L7y8',
    appId: '1:644663398536:ios:1de85880a155665e3c0f3d',
    messagingSenderId: '644663398536',
    projectId: 'foodanddrink-a3b0a',
    storageBucket: 'foodanddrink-a3b0a.appspot.com',
    iosBundleId: 'com.example.foodAndDrink',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDmYnWl-VessOmaayB-b34hpbp_c3hY_gw',
    appId: '1:644663398536:web:a05851b1607ad2f73c0f3d',
    messagingSenderId: '644663398536',
    projectId: 'foodanddrink-a3b0a',
    authDomain: 'foodanddrink-a3b0a.firebaseapp.com',
    storageBucket: 'foodanddrink-a3b0a.appspot.com',
    measurementId: 'G-BJHGX6DF4T',
  );
}
