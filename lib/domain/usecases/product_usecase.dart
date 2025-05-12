import '../entities/product.dart';
import '../../data/repository/product_repository_impl.dart';

class GetProducts {
  final ProductRepositoryImpl repository;

  GetProducts(this.repository);

  Future<List<Product>> call() {
    return repository.fetchProducts();
  }
}

class AddProduct {
  final ProductRepositoryImpl repository;

  AddProduct(this.repository);

  Future<void> call(Product product) {
    return repository.saveProduct(product);
  }
}
