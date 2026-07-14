import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;
  RemoveFromCartUseCase(this.repository);

  Future<void> call(String userId, Product product) async {
  repository.removeFromCart(userId, product);
}
}
