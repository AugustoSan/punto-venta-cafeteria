import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:punto_venta/services/auth_service.dart';
import '../../models/user.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _username = '';

  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;

  Future<void> checkLogin() async {
    final authBox = await Hive.openBox<String>('auth');
    _username = authBox.get('loggedInUser', defaultValue: '')!;
    _isLoggedIn = _username.isNotEmpty;
    notifyListeners();
  }

  Future<bool> login(String name, String password) async {
    print('Login attempt: $name, $password');
    final userBox = await Hive.openBox<User>('users');
    final user = userBox.get(name);
    final users = userBox.listenable();
    users.addListener(() {
      print('User list changed: ${userBox.values}');
    });
    if (user != null && AuthService.verifyPassword(password, user.passwordHash)) {
      final authBox = await Hive.openBox<String>('auth');
      await authBox.put('loggedInUser', name);
      _username = name;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final authBox = await Hive.openBox<String>('auth');
    await authBox.delete('loggedInUser');
    _username = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}
