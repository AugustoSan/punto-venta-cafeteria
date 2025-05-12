import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punto_venta/presentation/providers/auth_provider.dart';
import 'package:punto_venta/presentation/providers/business_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext ctx) {
    final username = ctx.read<AuthProvider>().username;
    final business = ctx.read<BusinessProvider>().business;
    return Scaffold(
      appBar: AppBar(
        title: Text(business?.name ?? 'Sin Nombre'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ctx.read<AuthProvider>().logout(),
          ),
        ],
      ),
      drawer: Drawer(
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
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
              onTap: () {
                Navigator.pushNamed(ctx, '/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pop(ctx);
                // Handle navigation
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ayuda'),
              onTap: () {
                Navigator.pop(ctx);
                // Handle navigation
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Has iniciado sesión como:\n$username'),
      ),
    );
  }
}
