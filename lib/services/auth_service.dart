import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';

class AuthService {
  // Caja donde está el mapa email → User
  final Box<User> _userBox = Hive.box<User>('users');
  // Caja donde guardamos el email del user activo
  final Box<String> _authBox = Hive.box<String>('auth');

  // Función para hashear la contraseña
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<bool> login(String email, String password) async {
    final user = _userBox.get(email);
    if (user == null) return false;

    final hash = hashPassword(password);
    if (hash != user.passwordHash) return false;

    // guardamos sesión
    await _authBox.put('currentUser', email);
    return true;
  }

  String? get currentUserEmail => _authBox.get('currentUser');

  Future<void> logout() async {
    await _authBox.delete('currentUser');
  }
}
