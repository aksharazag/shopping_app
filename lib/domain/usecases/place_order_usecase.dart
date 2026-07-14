import 'package:shopping_app/domain/repositories/order_repository.dart';

import '../repositories/cart_repository.dart';


class PlaceOrderUseCase {
  final CartRepository repository;
  final OrderRepository orderRepository;

  PlaceOrderUseCase(this.repository,this.orderRepository);

  Future<void> call(String userId) async {
    // Get current cart items
    final cartItems = await repository.getCartItems(userId);

    if (cartItems.isEmpty) return;
    // Save cart items as order
    await orderRepository.saveOrder(userId,cartItems);

    // Clear cart
    await repository.clearCart(userId);
  }

}