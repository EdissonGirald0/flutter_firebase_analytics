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
      title: 'Firebase Analytics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(
        title: 'Firebase Analytics',
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
      // Only strings, numbers & null (longs & doubles for android, ints and doubles for iOS) are supported for default event parameters:
      await widget.analytics.setDefaultEventParameters(<String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true.toString(),
      });
      setMessage('setDefaultEventParameters tuvo exito');
    }
  }
// Función para probar el registro de un evento personalizado.
  Future<void> _sendAnalyticsEvent() async {
    // Only strings and numbers (longs & doubles for android, ints and doubles for iOS) are supported for GA custom event parameters:
    // https://firebase.google.com/docs/reference/ios/firebaseanalytics/api/reference/Classes/FIRAnalytics#+logeventwithname:parameters:
    // https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics#public-void-logevent-string-name,-bundle-params
    await widget.analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        // Only strings and numbers (ints & doubles) are supported for GA custom event parameters:
        // https://developers.google.com/analytics/devguides/collection/analyticsjs/custom-dims-mets#overview
        'bool': true.toString(),
      },
    );

    setMessage('logEvent tuvo exito');
  }

  Future<void> _testSetUserId() async {
    await widget.analytics.setUserId(id: 'some-user');
    setMessage('setUserId tuvo exito');
  }

  Future<void> _testSetCurrentScreen() async {
    await widget.analytics.setCurrentScreen(
      screenName: 'Analytics Demo',
      screenClassOverride: 'AnalyticsDemo',
    );
    setMessage('setCurrentScreen tuvo exito');
  }

  Future<void> _testSetAnalyticsCollectionEnabled() async {
    await widget.analytics.setAnalyticsCollectionEnabled(false);
    await widget.analytics.setAnalyticsCollectionEnabled(true);
    setMessage('setAnalyticsCollectionEnabled tuvo exito');
  }

  Future<void> _testSetSessionTimeoutDuration() async {
    await widget.analytics
        .setSessionTimeoutDuration(const Duration(milliseconds: 20000));
    setMessage('setSessionTimeoutDuration tuvo exito');
  }

  Future<void> _testSetUserProperty() async {
    await widget.analytics.setUserProperty(name: 'regular', value: 'indeed');
    setMessage('setUserProperty tuvo exito');
  }

  Future<void> _testAppInstanceId() async {
    String? id = await widget.analytics.appInstanceId;
    if (id != null) {
      setMessage('appInstanceId succeeded: $id');
    } else {
      setMessage('appInstanceId falló, consentimiento rechazado');
    }
  }

  Future<void> _testResetAnalyticsData() async {
    await widget.analytics.resetAnalyticsData();
    setMessage('resetAnalyticsData tuvo éxito');
  }
// Otras funciones de prueba para diferentes funciones de Firebase Analytics.
  AnalyticsEventItem itemCreator() {
    return AnalyticsEventItem(
      affiliation: 'affil',
      coupon: 'coup',
      creativeName: 'creativeName',
      creativeSlot: 'creativeSlot',
      discount: 2.22,
      index: 3,
      itemBrand: 'itemBrand',
      itemCategory: 'itemCategory',
      itemCategory2: 'itemCategory2',
      itemCategory3: 'itemCategory3',
      itemCategory4: 'itemCategory4',
      itemCategory5: 'itemCategory5',
      itemId: 'itemId',
      itemListId: 'itemListId',
      itemListName: 'itemListName',
      itemName: 'itemName',
      itemVariant: 'itemVariant',
      locationId: 'locationId',
      price: 9.99,
      currency: 'USD',
      promotionId: 'promotionId',
      promotionName: 'promotionName',
      quantity: 1,
    );
  }

  Future<void> _testAllEventTypes() async {
    await widget.analytics.logAddPaymentInfo();
    await widget.analytics.logAddToCart(
      currency: 'USD',
      value: 123,
      items: [itemCreator(), itemCreator()],
    );
    await widget.analytics.logAddToWishlist();
    await widget.analytics.logAppOpen();
    await widget.analytics.logBeginCheckout(
      value: 123,
      currency: 'USD',
      items: [itemCreator(), itemCreator()],
    );
    await widget.analytics.logCampaignDetails(
      source: 'source',
      medium: 'medium',
      campaign: 'campaign',
      term: 'term',
      content: 'content',
      aclid: 'aclid',
      cp1: 'cp1',
    );
    await widget.analytics.logEarnVirtualCurrency(
      virtualCurrencyName: 'bitcoin',
      value: 345.66,
    );

    await widget.analytics.logGenerateLead(
      currency: 'USD',
      value: 123.45,
    );
    await widget.analytics.logJoinGroup(
      groupId: 'test group id',
    );
    await widget.analytics.logLevelUp(
      level: 5,
      character: 'witch doctor',
    );
    await widget.analytics.logLogin(loginMethod: 'login');
    await widget.analytics.logPostScore(
      score: 1000000,
      level: 70,
      character: 'tiefling cleric',
    );
    await widget.analytics
        .logPurchase(currency: 'USD', transactionId: 'transaction-id');
    await widget.analytics.logSearch(
      searchTerm: 'hotel',
      numberOfNights: 2,
      numberOfRooms: 1,
      numberOfPassengers: 3,
      origin: 'test origin',
      destination: 'test destination',
      startDate: '2015-09-14',
      endDate: '2015-09-16',
      travelClass: 'test travel class',
    );
    await widget.analytics.logSelectContent(
      contentType: 'test content type',
      itemId: 'test item id',
    );
    await widget.analytics.logSelectPromotion(
      creativeName: 'promotion name',
      creativeSlot: 'promotion slot',
      items: [itemCreator()],
      locationId: 'United States',
    );
    await widget.analytics.logSelectItem(
      items: [itemCreator(), itemCreator()],
      itemListName: 't-shirt',
      itemListId: '1234',
    );
    await widget.analytics.logScreenView(
      screenName: 'tabs-page',
    );
    await widget.analytics.logViewCart(
      currency: 'USD',
      value: 123,
      items: [itemCreator(), itemCreator()],
    );
    await widget.analytics.logShare(
      contentType: 'test content type',
      itemId: 'test item id',
      method: 'facebook',
    );
    await widget.analytics.logSignUp(
      signUpMethod: 'test sign up method',
    );
    await widget.analytics.logSpendVirtualCurrency(
      itemName: 'test item name',
      virtualCurrencyName: 'bitcoin',
      value: 34,
    );
    await widget.analytics.logViewPromotion(
      creativeName: 'promotion name',
      creativeSlot: 'promotion slot',
      items: [itemCreator()],
      locationId: 'United States',
      promotionId: '1234',
      promotionName: 'big sale',
    );
    await widget.analytics.logRefund(
      currency: 'USD',
      value: 123,
      items: [itemCreator(), itemCreator()],
    );
    await widget.analytics.logTutorialBegin();
    await widget.analytics.logTutorialComplete();
    await widget.analytics
        .logUnlockAchievement(id: 'toda la API de Firebase cubierta');
    await widget.analytics.logViewItem(
      currency: 'usd',
      value: 1000,
      items: [itemCreator()],
    );
    await widget.analytics.logViewItemList(
      itemListId: 't-shirt-4321',
      itemListName: 'green t-shirt',
      items: [itemCreator()],
    );
    await widget.analytics.logViewSearchResults(
      searchTerm: 'test search term',
    );
    setMessage('Todos los eventos estándar se registraron correctamente');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            onPressed: _sendAnalyticsEvent,
            child: const Text('prueba Registro Evento'),
          ),
          MaterialButton(
            onPressed: _testAllEventTypes,
            child: const Text('Probar tipos de eventos estándar'),
          ),
          MaterialButton(
            onPressed: _testSetUserId,
            child: const Text('Conjunto de prueba UserId'),
          ),
          MaterialButton(
            onPressed: _testSetCurrentScreen,
            child: const Text('Conjunto de prueba Pantalla actual'),
          ),
          MaterialButton(
            onPressed: _testSetAnalyticsCollectionEnabled,
            child: const Text('Conjunto de pruebas AnalyticsCollection habilitado'),
          ),
          MaterialButton(
            onPressed: _testSetSessionTimeoutDuration,
            child: const Text('set de prueba Duración del tiempo de espera '),
          ),
          MaterialButton(
            onPressed: _testSetUserProperty,
            child: const Text('Conjunto de prueba UserProperty'),
          ),
          MaterialButton(
            onPressed: _testAppInstanceId,
            child: const Text('set de prueva appInstanceId'),
          ),
          MaterialButton(
            onPressed: _testResetAnalyticsData,
            child: const Text('Restablecimiento de pruebaAnalyticsData'),
          ),
          MaterialButton(
            onPressed: _setDefaultEventParameters,
            child: const Text('Conjunto de prueba DefaultEventParameters'),
          ),
          Text(
            _message,
            style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
