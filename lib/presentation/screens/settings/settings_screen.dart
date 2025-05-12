import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:punto_venta/domain/entities/business_config.dart';
import '../../providers/business_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BusinessProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nombre del Negocio',
              ),
              onChanged: (value) => provider.updateBusinessName(value),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<BusinessType>(
              decoration: const InputDecoration(
                labelText: 'Tipo de Negocio',
              ),
              value: provider.businessType,
              items: BusinessType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
              onChanged: (value) => provider.updateBusinessType(value!),
            ),
          ],
        ),
      ),
    );
  }
}
