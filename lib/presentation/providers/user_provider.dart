// lib/presentation/providers/user_provider.dart
import 'package:flutter/material.dart';
import 'package:punto_venta/domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _repo;

  User? _user;
  User? get user => _user;

  UserProvider(this._repo);

  Future<void> initialize() async {
    await _repo.initialize();
  }

  Future<User?> getUser(String username) async {
    _user = await _repo.getUser(username);
    notifyListeners();
    return _user;
  }

  Future<bool> validatePassword(String username, String password) async {
    return await _repo.validatePassword(username, password);
  }

  // Future<void> saveUser(User user) async {
  //   _user = user;
  //   await _repo.saveUser(user);
  //   notifyListeners();
  // }
}
