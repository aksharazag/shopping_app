import '../../data/models/order_model_hive.dart';
import '../entities/product.dart';

abstract class OrderRepository {
  Future<void> saveOrder(String userId, List<Product> items);
  Future<List<OrderModelHive>> getOrders(String userId);
}