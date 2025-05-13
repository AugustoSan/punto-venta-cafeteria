import 'package:hive/hive.dart';
import 'package:punto_venta/data/local/app_database.dart';
import 'package:punto_venta/domain/entities/boxes.dart';
import 'package:punto_venta/domain/entities/user.dart';
import 'package:punto_venta/domain/repositories/user_repository.dart';
import 'package:punto_venta/services/auth_service.dart';

class UserRepositoryImpl implements UserRepository {
  static const _AUTH_BOX = Boxes.authBox;
  static const _AUTH_KEY = Boxes.key;
  final AppDatabase _db;

  UserRepositoryImpl(this._db);

  @override
  Future<void> initialize() async {
    // Si no hay usuarios, creamos uno por defecto
    final existing = await _db.select(_db.usersModel).get();
    if (existing.isEmpty) {
      final hash = AuthService.hashPassword('admin');
      await _db.into(_db.usersModel).insert(
        UsersModelCompanion.insert(
          name: 'admin',
          email: 'admin@example.com', // o lo que prefieras
          password: hash,
        ),
      );
    }
  }

  @override
  Future<User?> getUser(String username) async {
    final query = _db.select(_db.usersModel)
      ..where((u) => u.name.equals(username));
    final row = await query.getSingleOrNull();
    if (row == null) return null;

    return User(
      userName:     row.name,
      passwordHash: row.password,
    );
  }

  @override
  Future<bool> validatePassword(String username, String password) async {
    final user = await getUser(username);
    return user != null && AuthService.verifyPassword(password, user.passwordHash);
  }

  Future<String?> getLoggedInUser() async {
    final box = await Hive.openBox<String>(_AUTH_BOX);
    final user = box.get(_AUTH_KEY);
    return (user != null && user.isNotEmpty) ? user : null;
  }
}
