import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetailsUseCase {
  final ProductRepository repository;
  GetProductDetailsUseCase(this.repository);

  Future<Product> call(String productId) async {
    return await repository.getProductById(productId);
  }
}
