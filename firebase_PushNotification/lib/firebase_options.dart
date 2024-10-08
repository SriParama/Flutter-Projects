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
    apiKey: 'AIzaSyCwFazPe1byfSmMuyWzzmGNUirT2I9_F_c',
    appId: '1:62925734335:web:da458b3e261e581566a10a',
    messagingSenderId: '62925734335',
    projectId: 'fir-demo-f1f61',
    authDomain: 'fir-demo-f1f61.firebaseapp.com',
    storageBucket: 'fir-demo-f1f61.appspot.com',
    measurementId: 'G-6WTHBFP151',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWwwoQqIdkNF1E0IPDR5eqwHuCMEbPFVk',
    appId: '1:62925734335:android:a075cbe0ff28328c66a10a',
    messagingSenderId: '62925734335',
    projectId: 'fir-demo-f1f61',
    storageBucket: 'fir-demo-f1f61.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVVr4aXfHDl4pAcarL3TyIGIWD_x-jJao',
    appId: '1:62925734335:ios:c0fa642253d24ef466a10a',
    messagingSenderId: '62925734335',
    projectId: 'fir-demo-f1f61',
    storageBucket: 'fir-demo-f1f61.appspot.com',
    iosBundleId: 'com.example.firebaseDemo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVVr4aXfHDl4pAcarL3TyIGIWD_x-jJao',
    appId: '1:62925734335:ios:a277bbd52599e43d66a10a',
    messagingSenderId: '62925734335',
    projectId: 'fir-demo-f1f61',
    storageBucket: 'fir-demo-f1f61.appspot.com',
    iosBundleId: 'com.example.firebaseDemo.RunnerTests',
  );
}
