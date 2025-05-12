import 'package:hive/hive.dart';
import 'package:punto_venta/models/userModel.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../services/auth_service.dart';
import '../../domain/entities/boxes.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
class AuthRepositoryImpl implements AuthRepository {
  static const _AUTH_BOX    = Boxes.authBox;
  static const _USER_BOX    = Boxes.usersBox;
  static const _AUTH_KEY    = 'loggedInUser';

  @override
  Future<String?> getLoggedInUser() async {
    final box = await Hive.openBox<String>(_AUTH_BOX);
    final user = box.get(_AUTH_KEY);
    return user != null && user.isNotEmpty ? user : null;
  }

  @override
Future<bool> login(String username, String password) async {
  final userBox = await Hive.openBox<UserModel>(_USER_BOX);

  UserModel? user;
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
