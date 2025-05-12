import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:punto_venta/models/business.dart';
import 'package:punto_venta/presentation/providers/auth_provider.dart';

import 'models/user.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/providers/business_provider.dart';
import 'presentation/screens/login/login_screen.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BusinessAdapter());

  // Box de usuarios
  final userBox = await Hive.openBox<User>('users');
  // Box de negocio
  await Hive.openBox<Business>('business');
  // Si está vacío, creamos un usuario de ejemplo:
  if (userBox.isEmpty) {
    // contraseña: "admin"
    final hash = AuthService.hashPassword('admin');
    await userBox.add(User(
      userName: 'admin',
      passwordHash: hash,
    ));
  }

  // Box de sesión (guardaremos el email del user logueado)
  await Hive.openBox<String>('auth');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkLogin()),
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
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
