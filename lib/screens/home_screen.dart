import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext ctx) {
    final email = ctx.read<AuthProvider>().userEmail;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ctx.read<AuthProvider>().logout(),
          )
        ],
      ),
      body: Center(
        child: Text('Has iniciado sesión como:\n$email'),
      ),
    );
  }
}
