import 'package:hive/hive.dart';
import 'package:shopping_app/data/models/cart_product_model_hive.dart';
import '../../domain/entities/product.dart';

part 'order_model_hive.g.dart';

@HiveType(typeId: 2)
class OrderModelHive extends HiveObject {
  @HiveField(0)
  final String orderId;

  @HiveField(1)
  final List<CartProductModel> items;

  @HiveField(2)
  final DateTime dateTime;

  OrderModelHive({
    required this.orderId,
    required this.items,
    required this.dateTime,
  });
}
