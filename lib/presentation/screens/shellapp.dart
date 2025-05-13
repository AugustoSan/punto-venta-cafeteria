import 'package:flutter/material.dart';
import 'package:punto_venta/presentation/screens/home/home_screen.dart';
import 'package:punto_venta/presentation/screens/settings/settings_screen.dart';
import 'package:punto_venta/presentation/widgets/appbar_custom.dart';
import 'package:punto_venta/presentation/widgets/drawer_custom.dart';

class ShellApp extends StatelessWidget {
  final _shellNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      drawer: DrawerCustom(navigatorKey: _shellNavigatorKey),
      body: Navigator(
        key: _shellNavigatorKey,
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          Widget page;
          switch (settings.name) {
            case '/settings':
              page = const SettingsScreen();
              break;
            case '/home':
              page = const HomeScreen();
              break;
            default:
              page = const HomeScreen();
          }
          return MaterialPageRoute(builder: (_) => page, settings: settings);
        },
      ),
    );
  }
}
