enum BusinessType { restaurante, cafeteria, fonda, foodTruck }

class BusinessConfig {
  final String name;                // Nombre del local
  final String currency;            // Ej: "MXN", "USD"
  final double taxPercent;          // IVA u otro impuesto
  final BusinessType type;          // Tipo de negocio
  final List<String> enabledModules;// Ej: ["mesas","takeaway","delivery"]

  BusinessConfig({
    required this.name,
    required this.currency,
    required this.taxPercent,
    required this.type,
    required this.enabledModules,
  });
}
