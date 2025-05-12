import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _authService = AuthService();
  bool _loggedIn = false;
  bool get isLoggedIn => _loggedIn;
  String? get userEmail => _authService.currentUserEmail;

  Future<bool> login(String email, String pass) async {
    final ok = await _authService.login(email.trim(), pass);
    if (ok) {
      _loggedIn = true;
      notifyListeners();
    }
    return ok;
  }

  Future<void> logout() async {
    await _authService.logout();
    _loggedIn = false;
    notifyListeners();
  }

  Future<void> checkLogin() async {
    _loggedIn = _authService.currentUserEmail != null;
    notifyListeners();
  }
}
