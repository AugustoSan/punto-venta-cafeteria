import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/business_config.dart';
import '../../models/business.dart';

class BusinessProvider with ChangeNotifier {
  String _businessName = 'Mi Negocio';
  BusinessType _businessType = BusinessType.cafeteria;
  Business? _business;

  String get businessName => _businessName;
  BusinessType get businessType => _businessType;
  Business? get business => _business;

  void updateBusinessName(String name) {
    _businessName = name;
    notifyListeners();
  }

  void updateBusinessType(BusinessType type) {
    _businessType = type;
    notifyListeners();
  }

  Future<void> loadBusinessData() async {
    final box = await Hive.openBox<Business>('business');
    if (box.isNotEmpty) {
      _business = box.getAt(0);
      notifyListeners();
    }
  }
}
