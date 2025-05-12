import '../entities/business.dart';

abstract class BusinessRepository {
  Future<Business?> loadBusiness();
  Future<void> saveBusiness(Business config);
}