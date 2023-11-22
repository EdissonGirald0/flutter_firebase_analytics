// Importa las bibliotecas necesarias para trabajar con Flutter y Firebase.
import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Importa archivos locales que contienen opciones de Firebase y la página de pestañas.
import 'firebase_options.dart';
import 'tabs_page.dart';

// Función principal que inicializa la aplicación Flutter y Firebase.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// Definición de la aplicación principal.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Configuración básica de la aplicación, incluyendo el tema y el objeto FirebaseAnalytics.
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Analytics Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: 'Firebase Analytics Demo',
        analytics: analytics,
        observer: observer,
      ),
    );
  }
}

// Página principal de la aplicación.
class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Estado de la página principal que contiene lógica y funciones de prueba.
class _MyHomePageState extends State<MyHomePage> {
  // Mensaje que se mostrará en la interfaz de usuario.
  String _message = '';

  // Función para actualizar el mensaje en la interfaz de usuario.
  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  // Función para probar la configuración de parámetros predeterminados del evento.
  Future<void> _setDefaultEventParameters() async {
    if (kIsWeb) {
      setMessage(
        '"setDefaultEventParameters()" no es compatible en la plataforma web',
      );
    } else {
      await widget.analytics.setDefaultEventParameters(<String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true.toString(),
      });
      setMessage('setDefaultEventParameters exitoso');
    }
  }

  // Función para probar el registro de un evento personalizado.
  Future<void> _sendAnalyticsEvent() async {
    await widget.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true.toString(),
      },
    );

    setMessage('logEvent exitoso');
  }

  // Otras funciones de prueba para diferentes funciones de Firebase Analytics.

  // ...

  // Interfaz de usuario de la aplicación.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          // Botones para probar las diferentes funciones.
          MaterialButton(
            onPressed: _sendAnalyticsEvent,
            child: const Text('Test logEvent'),
          ),
          MaterialButton(
            onPressed: _setDefaultEventParameters,
            child: const Text('Test setDefaultEventParameters'),
          ),
          // Otros botones de prueba...
          Text(
            _message,
            style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a otra página cuando se presiona el botón flotante.
          Navigator.of(context).push(
            MaterialPageRoute<TabsPage>(
              settings: const RouteSettings(name: TabsPage.routeName),
              builder: (BuildContext context) {
                return TabsPage(widget.observer);
              },
            ),
          );
        },
        child: const Icon(Icons.tab),
      ),
    );
  }
}