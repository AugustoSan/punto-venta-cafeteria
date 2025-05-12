import 'package:hive/hive.dart';
import '../../domain/entities/business.dart';
import '../../domain/repositories/business_repository.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final Box<Business> box;

  BusinessRepositoryImpl(this.box);

  @override
  Future<Business?> loadBusiness() async {
    return box.isNotEmpty ? box.getAt(0) : null;
  }

  @override
  Future<void> saveBusiness(Business config) async {
    if (box.isEmpty) {
      await box.add(config);
    } else {
      await box.putAt(0, config);
    }
  }
}
