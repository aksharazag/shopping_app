import 'package:shopping_app/domain/entities/product.dart';
import 'package:shopping_app/domain/repositories/cart_repository.dart';

class AddToCartUseCase{
  final CartRepository repository;
  AddToCartUseCase(this.repository);

  Future<void> call(String userId, Product product) => repository.addToCart(userId, product);
}