import 'package:hive/hive.dart';
import 'package:punto_venta/domain/entities/user.dart';
import 'package:punto_venta/domain/repositories/user_repository.dart';
import 'package:punto_venta/models/userModel.dart';
import 'package:punto_venta/services/auth_service.dart';

class UserRepositoryImpl implements UserRepository {
  final Box<UserModel> box;

  UserRepositoryImpl(this.box);

  @override
  Future<void> initialize() async {
    if (box.isEmpty) {
      // contraseña: "admin"
      final hash = AuthService.hashPassword('admin');
      await box.add(
        UserModel(
          userName: 'admin',
          passwordHash: hash,
        ),
      );
    }
  }

  @override
  Future<User?> getUser(String username) async {
    if (box.isEmpty) return null;
    
    final model = box.values.firstWhere((u) => u.userName == username);
    
    return User(
      userName:       model.userName,
      passwordHash:   model.passwordHash,
    );
  }

  @override
  Future<bool> validatePassword(String username, String password) async {
    final user = await getUser(username);
    return user != null && AuthService.verifyPassword(password, user.passwordHash);
  }
}
