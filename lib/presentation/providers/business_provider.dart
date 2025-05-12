// lib/presentation/providers/business_provider.dart
import 'package:flutter/material.dart';
import '../../domain/entities/business.dart';
import '../../domain/repositories/business_repository.dart';

class BusinessProvider with ChangeNotifier {
  final BusinessRepository _repo;

  Business? _business;
  Business? get business => _business;

  BusinessProvider(this._repo);

  Future<void> loadBusinessData() async {
    _business = await _repo.loadBusiness();
    notifyListeners();
  }

  Future<void> updateBusinessName(String name) async {
    if (_business != null) {
      _business = _business!.copyWith(name: name);
      await _repo.saveBusiness(_business!);
      notifyListeners();
    }
  }

  Future<void> updateBusinessType(BusinessType type) async {
    if (_business != null) {
      _business = _business!.copyWith(type: type);
      await _repo.saveBusiness(_business!);
      notifyListeners();
    }
  }

  Future<void> saveBusiness(Business config) async {
    _business = config;
    await _repo.saveBusiness(config);
    notifyListeners();
  }
}
