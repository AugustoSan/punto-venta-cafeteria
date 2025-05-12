// lib/di/locator.dart
import 'package:hive/hive.dart';
import 'package:punto_venta/data/repository/auth_repository_impl.dart';
import 'package:punto_venta/domain/repositories/auth_repository.dart';
import 'package:punto_venta/presentation/providers/auth_provider.dart';
import '../data/repository/business_repository_impl.dart';
import '../domain/repositories/business_repository.dart';
import '../presentation/providers/business_provider.dart';
import '../domain/entities/business.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // --- Negocio ---
  final businessBox = await Hive.openBox<Business>('business');
  getIt.registerLazySingleton<BusinessRepository>(
    () => BusinessRepositoryImpl(businessBox),
  );
  getIt.registerFactory<BusinessProvider>(
    () => BusinessProvider(getIt<BusinessRepository>()),
  );

  // --- Autenticación ---
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(getIt<AuthRepository>())..checkLogin(),
  );
}
