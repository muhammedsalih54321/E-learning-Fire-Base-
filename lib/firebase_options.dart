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
    apiKey: 'AIzaSyA9Ft723rq7E7XXCdLmbxvUAYnNhCHy8QM',
    appId: '1:943545758147:web:fc91ae16b681aa0a574d76',
    messagingSenderId: '943545758147',
    projectId: 'e-learning-2bfaa',
    authDomain: 'e-learning-2bfaa.firebaseapp.com',
    storageBucket: 'e-learning-2bfaa.appspot.com',
    measurementId: 'G-YB7FDV93PD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmXSzLmar-lH2ColONFUCcPXD68v3RKGI',
    appId: '1:943545758147:android:8c354cd643705707574d76',
    messagingSenderId: '943545758147',
    projectId: 'e-learning-2bfaa',
    storageBucket: 'e-learning-2bfaa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL4yNE3sPrZbunxZjt7RVPWooQUObVvEw',
    appId: '1:943545758147:ios:9954998f29fbc3a6574d76',
    messagingSenderId: '943545758147',
    projectId: 'e-learning-2bfaa',
    storageBucket: 'e-learning-2bfaa.appspot.com',
    iosBundleId: 'com.example.eLearningFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAL4yNE3sPrZbunxZjt7RVPWooQUObVvEw',
    appId: '1:943545758147:ios:9954998f29fbc3a6574d76',
    messagingSenderId: '943545758147',
    projectId: 'e-learning-2bfaa',
    storageBucket: 'e-learning-2bfaa.appspot.com',
    iosBundleId: 'com.example.eLearningFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9Ft723rq7E7XXCdLmbxvUAYnNhCHy8QM',
    appId: '1:943545758147:web:7c6d36d2739512dd574d76',
    messagingSenderId: '943545758147',
    projectId: 'e-learning-2bfaa',
    authDomain: 'e-learning-2bfaa.firebaseapp.com',
    storageBucket: 'e-learning-2bfaa.appspot.com',
    measurementId: 'G-KR2TVRX3PG',
  );
}
