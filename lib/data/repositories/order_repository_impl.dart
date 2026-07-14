import 'package:hive/hive.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/cart_product_model_hive.dart';
import '../models/order_model_hive.dart';

class OrderRepositoryImpl implements OrderRepository {
  String safeBoxName(String userId) => 'orders_${userId.replaceAll('@', '_').replaceAll('.', '_')}';

  @override
  Future<void> saveOrder(String userId, List<Product> items) async {
    try {
      final box = await Hive.openBox<OrderModelHive>(safeBoxName(userId));
      final order = OrderModelHive(
        orderId: DateTime
            .now()
            .millisecondsSinceEpoch
            .toString(),
        items: items.map((p) =>
            CartProductModel(
              id: p.id,
              productName: p.productName,
              price: p.price,
              description: p.description,
              category: p.category,
              brand: p.brand,
              images: p.images,
              discount: p.discount ?? 0,
              quantity: p.quantity ?? 1,
            )).toList(),
        dateTime: DateTime.now(),
      );

      await box.add(order);
      print("Order saved! Order ID: ${order.orderId}, Items: ${order.items
          .length}");
    }catch (e,st){
      print("❌ Failed to save order: $e\n$st");

    }
  }

  @override
  Future<List<OrderModelHive>> getOrders(String userId) async {
    final box = await Hive.openBox<OrderModelHive>(safeBoxName(userId));
    return box.values.toList();
  }
}


