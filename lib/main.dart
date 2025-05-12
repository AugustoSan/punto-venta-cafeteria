import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:punto_venta/di/locator.dart';
import 'package:punto_venta/models/businessModel.dart';
import 'package:punto_venta/models/userModel.dart';
import 'package:punto_venta/presentation/providers/auth_provider.dart';
import 'package:punto_venta/presentation/providers/user_provider.dart';

import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/providers/business_provider.dart';
import 'presentation/screens/login/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(BusinessModelAdapter());
  

  // // Box de usuarios
  // final userBox = await Hive.openBox<User>('users');
  // // Box de negocio
  // final businessBox = await Hive.openBox<Business>('business');
  // // Si está vacío, creamos un usuario de ejemplo:
  // if (userBox.isEmpty) {
  //   // contraseña: "admin"
  //   final hash = AuthService.hashPassword('admin');
  //   await userBox.add(
  //     User(
  //       userName: 'admin',
  //       passwordHash: hash,
  //     ),
  //   );
  // }
  // // Si está vacío, creamos un negocio de ejemplo:
  // if (businessBox.isEmpty) {
  //   await businessBox.add(
  //     Business(
  //       name: 'Mi Negocio',
  //       currency: 'MXN',
  //       taxPercent: 16.0,
  //       type: 1,
  //       enabledModules: ['productos', 'ventas', 'compras'],
  //     ),
  //   );
  // }

  // Box de sesión (guardaremos el email del user logueado)
  // await Hive.openBox<String>('auth');

  await setupLocator();  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<BusinessProvider>()..loadBusinessData()),
        ChangeNotifierProvider(create: (_) => getIt<UserProvider>()..initialize()),
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punto de Venta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
      ),
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => Consumer<AuthProvider>(
          builder: (ctx, auth, _) =>
            auth.isLoggedIn ? const HomeScreen() : const LoginScreen(),
        ),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
