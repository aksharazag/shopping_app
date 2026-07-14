import 'package:shopping_app/domain/repositories/cart_repository.dart';

import '../entities/product.dart';

class LoadCartUseCase {
  final CartRepository repository;
  LoadCartUseCase(this.repository);
  Future<List<Product>> call(String userId) => repository.getCartItems(userId);
}