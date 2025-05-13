// lib/di/locator.dart
import 'package:hive/hive.dart';
import 'package:punto_venta/data/local/app_database.dart';
import 'package:punto_venta/data/repository/auth_repository_impl.dart';
import 'package:punto_venta/data/repository/menuitem_repository_impl.dart';
import 'package:punto_venta/data/repository/user_repository_impl.dart';
import 'package:punto_venta/domain/entities/boxes.dart';
import 'package:punto_venta/domain/repositories/auth_repository.dart';
import 'package:punto_venta/domain/repositories/menuitem_repository.dart';
import 'package:punto_venta/domain/repositories/user_repository.dart';
import 'package:punto_venta/models/businessModel.dart';
import 'package:punto_venta/presentation/providers/auth_provider.dart';
import 'package:punto_venta/presentation/providers/menuitem_provider.dart';
import 'package:punto_venta/presentation/providers/user_provider.dart';
import '../data/repository/business_repository_impl.dart';
import '../domain/repositories/business_repository.dart';
import '../presentation/providers/business_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator(AppDatabase db) async {

  // --- Negocio ---
  final businessBox = await Hive.openBox<BusinessModel>(Boxes.businessBox);
  getIt.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(businessBox),
  );
  getIt.registerFactory<BusinessProvider>(
    () => BusinessProvider(getIt<BusinessRepository>()),
  );

  // --- Usuarios ---
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(db),
  );
  getIt.registerFactory<UserProvider>(
    () => UserProvider(getIt<UserRepository>()),
  );

  // --- Autenticación ---
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(db),
  );
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(getIt<AuthRepository>())..checkLogin(),
  );

  // --- MenuItems ---
  getIt.registerLazySingleton<MenuItemRepository>(
    () => MenuItemRepositoryImpl(db),
  );
  getIt.registerFactory<MenuItemProvider>(
    () => MenuItemProvider(getIt<MenuItemRepository>()),
  );
}
