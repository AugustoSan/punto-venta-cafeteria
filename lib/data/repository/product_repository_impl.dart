import '../datasource/local/product_hive_ds.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryImpl {
  final ProductHiveDataSource dataSource;

  ProductRepositoryImpl(this.dataSource);

  Future<List<Product>> fetchProducts() {
    return dataSource.getAllProducts();
  }

  Future<void> saveProduct(Product product) {
    return dataSource.addProduct(product);
  }
}
