import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  // Box de usuarios
  final userBox = await Hive.openBox<User>('users');
  // Si está vacío, creamos un usuario de ejemplo:
  if (userBox.isEmpty) {
    // contraseña: "123456"
    final hash = AuthService.hashPassword('123456');
    await userBox.put('demo@ejemplo.com', User(
      userName: 'demo@ejemplo.com',
      passwordHash: hash,
    ));
  }

  // Box de sesión (guardaremos el email del user logueado)
  await Hive.openBox<String>('auth');

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..checkLogin(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'Login Local con Hive',
      home: Consumer<AuthProvider>(
        builder: (ctx, auth, _) =>
          auth.isLoggedIn ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }
}
