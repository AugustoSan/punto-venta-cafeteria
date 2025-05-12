import 'package:punto_venta/domain/entities/business.dart';
import 'package:punto_venta/domain/repositories/business_repository.dart';

class GetBusinessConfig {
  final BusinessRepository repo;
  GetBusinessConfig(this.repo);
  Future<Business?> call() => repo.loadBusiness();
}

class SaveBusinessConfig {
  final BusinessRepository repo;
  SaveBusinessConfig(this.repo);
  Future<void> call(Business cfg) => repo.saveBusiness(cfg);
}
