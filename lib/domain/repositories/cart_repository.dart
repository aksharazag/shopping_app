import '../entities/product.dart';

abstract class CartRepository {
  Future<List<Product>> getCartItems(String userId);
  Future<void> addToCart(String userId,Product product);
  Future<void> clearCart(String userId);
  Future<void> removeFromCart(String userId, Product product);
}
