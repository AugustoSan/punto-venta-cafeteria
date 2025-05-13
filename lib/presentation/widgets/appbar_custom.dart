import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punto_venta/presentation/providers/auth_provider.dart';
import 'package:punto_venta/presentation/providers/business_provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    return AppBar(
        title: Text(business?.name ?? 'Sin Nombre'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ctx.read<AuthProvider>().logout(),
          ),
        ],
      );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
