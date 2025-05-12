import 'package:punto_venta/data/repository/config_repository_impl.dart';
import 'package:punto_venta/domain/entities/business_config.dart';

class GetBusinessConfig {
  final ConfigRepository repo;
  GetBusinessConfig(this.repo);
  Future<BusinessConfig?> call() => repo.getConfig();
}

class SaveBusinessConfig {
  final ConfigRepository repo;
  SaveBusinessConfig(this.repo);
  Future<void> call(BusinessConfig cfg) => repo.setConfig(cfg);
}
