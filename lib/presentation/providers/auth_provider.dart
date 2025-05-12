import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:punto_venta/services/auth_service.dart';
import '../../models/user.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userEmail = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;

  Future<void> checkLogin() async {
    final authBox = await Hive.openBox<String>('auth');
    _userEmail = authBox.get('loggedInUser', defaultValue: '')!;
    _isLoggedIn = _userEmail.isNotEmpty;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final userBox = await Hive.openBox<User>('users');
    final user = userBox.get(email);
    if (user != null && AuthService.verifyPassword(password, user.passwordHash)) {
      final authBox = await Hive.openBox<String>('auth');
      await authBox.put('loggedInUser', email);
      _userEmail = email;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final authBox = await Hive.openBox<String>('auth');
    await authBox.delete('loggedInUser');
    _userEmail = '';
    _isLoggedIn = false;
    notifyListeners();
  }
}
