import 'package:hive/hive.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../../services/auth_service.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
class AuthRepositoryImpl implements AuthRepository {
  static const _AUTH_BOX    = 'auth';
  static const _USER_BOX    = 'users';
  static const _AUTH_KEY    = 'loggedInUser';

  @override
  Future<String?> getLoggedInUser() async {
    final box = await Hive.openBox<String>(_AUTH_BOX);
    final user = box.get(_AUTH_KEY);
    return user != null && user.isNotEmpty ? user : null;
  }

  @override
Future<bool> login(String username, String password) async {
  final userBox = await Hive.openBox<User>(_USER_BOX);

  User? user;
  try {
    user = userBox.values.firstWhere((u) => u.userName == username);
  } catch (_) {
    user = null;
  }

  if (user != null && AuthService.verifyPassword(password, user.passwordHash)) {
    final authBox = await Hive.openBox<String>(_AUTH_BOX);
    await authBox.put(_AUTH_KEY, username);
    return true;
  }
  return false;
}

  @override
  Future<void> logout() async {
    final box = await Hive.openBox<String>(_AUTH_BOX);
    await box.delete(_AUTH_KEY);
  }
}
