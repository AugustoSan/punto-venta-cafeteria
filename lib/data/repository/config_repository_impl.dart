import 'package:punto_venta/domain/entities/business_config.dart';

/// Contrato que define cómo obtener y guardar la configuración del negocio.
abstract class ConfigRepository {
  /// Devuelve la configuración actual, o `null` si no existe.
  Future<BusinessConfig?> getConfig();

  /// Guarda la configuración pasada.
  Future<void> setConfig(BusinessConfig config);
}
