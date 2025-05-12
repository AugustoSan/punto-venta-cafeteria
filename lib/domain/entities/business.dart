enum BusinessType { restaurante, cafeteria, fonda, foodTruck }

class Business {
  final String name;                // Nombre del local
  final String currency;            // Ej: "MXN", "USD"
  final double taxPercent;          // IVA u otro impuesto
  final BusinessType type;          // Tipo de negocio
  final List<String> enabledModules;// Ej: ["mesas","takeaway","delivery"]

  Business({
    required this.name,
    required this.currency,
    required this.taxPercent,
    required this.type,
    required this.enabledModules,
  });

  Business copyWith({
    String? name,
    String? currency,
    double? taxPercent,
    BusinessType? type,
    List<String>? enabledModules,
  }) {
    return Business(
      name:           name         ?? this.name,
      currency:       currency     ?? this.currency,
      taxPercent:     taxPercent   ?? this.taxPercent,
      type:           type         ?? this.type,
      enabledModules: enabledModules ?? this.enabledModules,
    );
  }
}
