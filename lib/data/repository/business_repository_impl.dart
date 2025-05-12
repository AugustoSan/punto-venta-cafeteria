import 'package:hive/hive.dart';
import 'package:punto_venta/models/businessModel.dart';
import '../../domain/entities/business.dart';
import '../../domain/repositories/business_repository.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final Box<BusinessModel> box;

  BusinessRepositoryImpl(this.box);

  @override
  Future<Business?> loadBusiness() async {
    if (box.isEmpty) return null;
    
    final model = box.getAt(0)!;
    
    return Business(
      name:           model.name,
      currency:       model.currency,
      taxPercent:     model.taxPercent,
      type:           BusinessType.values[model.type],
      enabledModules: model.enabledModules,
    );
  }

  @override
  Future<void> saveBusiness(Business biz) async {
    // mapeamos entidad a modelo
    final model = BusinessModel(
      name:           biz.name,
      currency:       biz.currency,
      taxPercent:     biz.taxPercent,
      type:           biz.type.index,
      enabledModules: biz.enabledModules,
    );
    if (box.isEmpty) {
      await box.add(model);
    } else {
      await box.putAt(0, model);
    }
  }
}
