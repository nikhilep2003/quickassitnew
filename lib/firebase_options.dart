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
    apiKey: 'AIzaSyCXak3BiuhvvcszPUZ69pI2wPH4EfqWpho',
    appId: '1:528221720193:web:5f363c1a47e880b5584780',
    messagingSenderId: '528221720193',
    projectId: 'quickassist-fd869',
    authDomain: 'quickassist-fd869.firebaseapp.com',
    storageBucket: 'quickassist-fd869.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgKZiksW-paX9tuMT7iL-P23LY63ahLkk',
    appId: '1:528221720193:android:c1ea12dbdbdda1dd584780',
    messagingSenderId: '528221720193',
    projectId: 'quickassist-fd869',
    storageBucket: 'quickassist-fd869.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDiEOgra3HU0MvxfXGn9qG-lx2EJed5n1o',
    appId: '1:528221720193:ios:7a1e572e9a7f454c584780',
    messagingSenderId: '528221720193',
    projectId: 'quickassist-fd869',
    storageBucket: 'quickassist-fd869.appspot.com',
    iosBundleId: 'com.example.quickassitnew',
  );
}
