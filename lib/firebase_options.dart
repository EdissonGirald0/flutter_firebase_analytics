// Archivo generado por FlutterFire CLI.
// Ignora advertencias relacionadas con la longitud de las líneas y clases con miembros solo estáticos.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Opciones [FirebaseOptions] predeterminadas para usar con tus aplicaciones Firebase.
///
/// Ejemplo:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  // Método estático que devuelve las opciones de Firebase según la plataforma actual.
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
          'DefaultFirebaseOptions no se ha configurado para macOS - '
          'puedes reconfigurarlo ejecutando FlutterFire CLI de nuevo.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions no se ha configurado para Windows - '
          'puedes reconfigurarlo ejecutando FlutterFire CLI de nuevo.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions no se ha configurado para Linux - '
          'puedes reconfigurarlo ejecutando FlutterFire CLI de nuevo.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions no es compatible con esta plataforma.',
        );
    }
  }

  // Opciones de Firebase para la plataforma web.
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA7Gv7pdnm2wnazQ3Ja0GuUtRnHy6ZPxPQ',
    appId: '1:453950730767:web:059da8f89e14d87c61297a',
    messagingSenderId: '453950730767',
    projectId: 'primer-proyecto-7054d',
    authDomain: 'primer-proyecto-7054d.firebaseapp.com',
    storageBucket: 'primer-proyecto-7054d.appspot.com',
    measurementId: 'G-PPH1SCRY0E',
  );

  // Opciones de Firebase para la plataforma Android.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBW3Dr5iK2LIjmRMgB80h3EUhoMzu-1L90',
    appId: '1:453950730767:android:94d70136cb16500861297a',
    messagingSenderId: '453950730767',
    projectId: 'primer-proyecto-7054d',
    storageBucket: 'primer-proyecto-7054d.appspot.com',
  );

  // Opciones de Firebase para la plataforma iOS.
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhAt44tzFz4xMBS9bI_O4wZ5EX34qmXe0',
    appId: '1:453950730767:ios:0df423718bbce26661297a',
    messagingSenderId: '453950730767',
    projectId: 'primer-proyecto-7054d',
    storageBucket: 'primer-proyecto-7054d.appspot.com',
    iosBundleId: 'com.example.appfirebase',
  );
}