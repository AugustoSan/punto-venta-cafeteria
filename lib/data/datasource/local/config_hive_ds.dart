import 'package:hive_flutter/hive_flutter.dart';
import 'package:punto_venta/domain/entities/business_config.dart';

abstract class ConfigLocalDataSource {
  Future<BusinessConfig?> loadConfig();
  Future<void> saveConfig(BusinessConfig config);
}

class ConfigHiveDataSource implements ConfigLocalDataSource {
  final box = Hive.box<BusinessConfig>('config');

  @override
  Future<BusinessConfig?> loadConfig() async =>
      box.get('businessConfig');

  @override
  Future<void> saveConfig(BusinessConfig config) async {
    await box.put('businessConfig', config);
  }
}
