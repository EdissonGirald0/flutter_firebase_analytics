import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// Página de pestañas que utiliza un controlador de pestañas y Firebase Analytics.
class TabsPage extends StatefulWidget {
  TabsPage(this.observer, {Key? key}) : super(key: key);

  final FirebaseAnalyticsObserver observer;

  // Nombre de la ruta de la página de pestañas.
  static const String routeName = '/tab';

  @override
  State<StatefulWidget> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with
        SingleTickerProviderStateMixin,
        RouteAware {
  // Instancia de Firebase Analytics.
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // Controlador de pestañas para gestionar el estado de las pestañas.
  late final TabController _controller = TabController(
    vsync: this,
    length: tabs.length,
    initialIndex: selectedIndex,
  );

  // Índice de la pestaña actualmente seleccionada.
  int selectedIndex = 0;

  // Lista de pestañas.
  final List<Tab> tabs = <Tab>[
    const Tab(text: 'LEFT'),
    const Tab(text: 'RIGHT'),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Suscribe la instancia actual al observador de Firebase Analytics.
    widget.observer.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    // Desinscribe la instancia actual del observador de Firebase Analytics al cerrar la página.
    widget.observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Configura un listener para el controlador de pestañas para actualizar el índice seleccionado.
    _controller.addListener(() {
      setState(() {
        if (selectedIndex != _controller.index) {
          selectedIndex = _controller.index;
          _sendCurrentTabToAnalytics();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Barra de pestañas en la parte inferior de la barra de aplicaciones.
        bottom: TabBar(
          controller: _controller,
          tabs: tabs,
        ),
      ),
      // Contenido de la página, cambia según la pestaña seleccionada.
      body: TabBarView(
        controller: _controller,
        children: tabs.map((Tab tab) {
          return Center(child: Text(tab.text!));
        }).toList(),
      ),
    );
  }

  // Método llamado cuando se empuja una nueva ruta en el navegador.
  @override
  void didPush() {
    _sendCurrentTabToAnalytics();
  }

  // Método llamado cuando se quita la ruta superior del navegador.
  @override
  void didPopNext() {
    _sendCurrentTabToAnalytics();
  }

  // Envía el nombre de la pantalla actual a Firebase Analytics.
  void _sendCurrentTabToAnalytics() {
    analytics.setCurrentScreen(
      screenName: '${TabsPage.routeName}/tab$selectedIndex',
    );
  }
}