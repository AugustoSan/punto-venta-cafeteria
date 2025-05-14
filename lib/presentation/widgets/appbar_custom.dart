import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:punto_venta/presentation/providers/business_provider.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget{
  final String currentRoute;
  const AppBarCustom({super.key, required this.currentRoute});


  @override
  Widget build(BuildContext ctx) {
    final business = ctx.watch<BusinessProvider>().business;
    print('currentRoute: $currentRoute');
    String title = (currentRoute == '/home')
      ? (business?.name ?? 'Sin Nombre')
      : _mapRouteToTitle(currentRoute);
    return AppBar(
      title: Text(title),
      backgroundColor: Theme.of(ctx).primaryColor,
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
    );
  }

  String _mapRouteToTitle(String route) {
    switch (route) {
      case '/settings':   return 'Configuración';
      case '/menuItems':  return 'Productos';
      case '/orders':     return 'Órdenes';
      case '/perfil':     return 'Perfil';
      case '/help':       return 'Ayuda';
      default:            return 'Punto de Venta';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
