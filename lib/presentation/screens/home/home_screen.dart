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
        title: Text(business?.name ?? 'Mi Negocio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ctx.read<AuthProvider>().logout(),
          )
        ],
      ),
      body: Center(
        child: Text('Has iniciado sesión como:\n$username'),
      ),
    );
  }
}
