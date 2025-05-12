import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:punto_venta/domain/entities/business.dart';
import '../../providers/business_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
} 

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameC = TextEditingController();
  final _currencyC = TextEditingController();
  final _taxC = TextEditingController();
  BusinessType _selectedType = BusinessType.cafeteria;


  @override
  Widget build(BuildContext context) {
    final business = context.read<BusinessProvider>().business;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameC,
              initialValue: business?.name ?? 'Sin nombre',
              decoration: const InputDecoration(
                labelText: 'Nombre del negocio',
              ),
              validator: (v) =>
                v != null && v.isEmpty ? 'Nombre del negocio inválido' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _currencyC,
              decoration: const InputDecoration(
                labelText: 'Moneda',
              ),
              validator: (v) =>
                v != null && v.isEmpty ? 'Moneda inválida' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _taxC,
              decoration: const InputDecoration(
                labelText: 'Porcentaje de IVA',
              ),
              validator: (v) =>
                v != null && v.isEmpty ? 'Porcentaje de IVA inválido' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<BusinessType>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Tipo de negocio',
              ),
              items: BusinessType.values.map((type) => DropdownMenuItem(
                value: type,
                child: Text(type.name),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Aquí guardamos los datos
                  final business = Business(
                    name: _nameC.text,
                    currency: _currencyC.text,
                    taxPercent: double.parse(_taxC.text),
                    type: _selectedType,
                    enabledModules: [],
                  );
                  context.read<BusinessProvider>().saveBusiness(business);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
