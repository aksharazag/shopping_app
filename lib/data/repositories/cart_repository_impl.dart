import 'package:hive/hive.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../models/cart_product_model_hive.dart';

class CartRepositoryImpl implements CartRepository {
  String safeBoxName(String userId) {
    return 'cart_${userId.replaceAll('@', '_').replaceAll('.', '_')}';
  }

  @override
  Future<List<Product>> getCartItems(String userId) async {
    //final safeBoxName = 'cart_${userId.replaceAll('@', '_').replaceAll('.', '_')}';

    final cartBox = await Hive.openBox<CartProductModel>(safeBoxName(userId));
    return cartBox.values
        .map(
          (c) => Product(
            id: c.id,
            productName: c.productName,
            price: c.price,
            description: c.description,
            category: c.category,
            brand: c.brand,
            images: c.images,
            discount: c.discount,
            quantity: c.quantity,
          ),
        )
        .toList();
  }

  Future<void> addToCart(String userId, Product product) async {
    final cartBox = await Hive.openBox<CartProductModel>(safeBoxName(userId));
    // Check if product already exists
    final existingIndex = cartBox.values.toList().indexWhere(
      (c) => c.id == product.id,
    );
    if (existingIndex != -1) {
      // Product already exists -> update quantity
      final existingItem = cartBox.getAt(existingIndex)!;
      existingItem.quantity += 1;
      await existingItem.save();
    } else {
      final cartProduct = CartProductModel(
        id: product.id,
        productName: product.productName,
        price: product.price,
        description: product.description,
        category: product.category,
        brand: product.brand,
        images: product.images,
        discount: product.discount,
        quantity: 1,
      );
      await cartBox.add(cartProduct);
    }

    // Ensure Hive writes are completed
    await cartBox.flush();

    // Print all current cart items in console
    print("Current cart items:");
    for (var item in cartBox.values) {
      print("${item.productName} - \$${item.price}");
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    final cartBox = await Hive.openBox<CartProductModel>(safeBoxName(userId));
    await cartBox.clear();
  }

  @override
  Future<void> removeFromCart(String userId, Product product) async {
    final box = await Hive.openBox<CartProductModel>(safeBoxName(userId));
    final index = box.values.toList().indexWhere((p) => p.id == product.id);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
