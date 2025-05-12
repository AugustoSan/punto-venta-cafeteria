import 'package:hive/hive.dart';
import 'package:punto_venta/domain/entities/product.dart';

class ProductHiveDataSource {
  final Box<Product> productBox;

  ProductHiveDataSource(this.productBox);

  Future<List<Product>> getAllProducts() async {
    return productBox.values.toList();
  }

  Future<void> addProduct(Product product) async {
    await productBox.put(product.id, product);
  }
}
