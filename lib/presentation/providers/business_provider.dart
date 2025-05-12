import 'package:flutter/material.dart';
import '../../domain/entities/business_config.dart';

class BusinessProvider with ChangeNotifier {
  String _businessName = 'Mi Negocio';
  BusinessType _businessType = BusinessType.cafeteria;

  String get businessName => _businessName;
  BusinessType get businessType => _businessType;

  void updateBusinessName(String name) {
    _businessName = name;
    notifyListeners();
  }

  void updateBusinessType(BusinessType type) {
    _businessType = type;
    notifyListeners();
  }
}
