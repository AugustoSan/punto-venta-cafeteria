import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punto_venta/presentation/providers/business_provider.dart';

class DrawerCustom extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const DrawerCustom({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(ctx).primaryColor,
              ),
              child: Text(
                business?.name ?? 'Sin Nombre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.of(ctx).pop(); // cierra el drawer
                navigatorKey.currentState!.pushNamed('/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                Navigator.of(ctx).pop(); // cierra el drawer
                navigatorKey.currentState!.pushNamed('/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                Navigator.of(ctx).pop(); // cierra el drawer
              navigatorKey.currentState!.pushNamed('/perfil');
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ayuda'),
              onTap: () {
                Navigator.of(ctx).pop(); // cierra el drawer
              navigatorKey.currentState!.pushNamed('/help');
              },
            ),
          ],
        ),
      );
  }
}
