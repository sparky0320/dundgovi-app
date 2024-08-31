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
    apiKey: 'AIzaSyA6pMJSemX_bJYPx5Ix_QFvTnzOwD0DOXo',
    appId: '1:138215864614:web:418fddb90da67e7860a9e7',
    messagingSenderId: '138215864614',
    projectId: 'gocare-394006',
    authDomain: 'gocare-394006.firebaseapp.com',
    storageBucket: 'gocare-394006.appspot.com',
    measurementId: 'G-9EJSFW6DHY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7iQCgHMBVTqhSWY3yYoKMmDWMv2SWIAY',
    appId: '1:138215864614:android:3ac3f313529234bf60a9e7',
    messagingSenderId: '138215864614',
    projectId: 'gocare-394006',
    storageBucket: 'gocare-394006.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIgl3mdw9DVAiNz0ruiRbi6aCxYIry2wg',
    appId: '1:138215864614:ios:cbb80eca423800ce60a9e7',
    messagingSenderId: '138215864614',
    projectId: 'gocare-394006',
    storageBucket: 'gocare-394006.appspot.com',
    androidClientId:
        '138215864614-c8b9usevo5nrdecmp72dmljujbllebo4.apps.googleusercontent.com',
    iosClientId:
        '138215864614-ddmee5tr46gp4rg0okgqbjagtogh9dn3.apps.googleusercontent.com',
    iosBundleId: 'com.carepay.moveToEarn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIgl3mdw9DVAiNz0ruiRbi6aCxYIry2wg',
    appId: '1:138215864614:ios:cbb80eca423800ce60a9e7',
    messagingSenderId: '138215864614',
    projectId: 'gocare-394006',
    storageBucket: 'gocare-394006.appspot.com',
    androidClientId:
        '138215864614-c8b9usevo5nrdecmp72dmljujbllebo4.apps.googleusercontent.com',
    iosClientId:
        '138215864614-ddmee5tr46gp4rg0okgqbjagtogh9dn3.apps.googleusercontent.com',
    iosBundleId: 'com.carepay.moveToEarn',
  );
}
