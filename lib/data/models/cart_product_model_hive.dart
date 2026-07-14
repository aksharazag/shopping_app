import 'package:hive/hive.dart';

part 'cart_product_model_hive.g.dart';

@HiveType(typeId: 1) // unique ID for Hive adapter
class CartProductModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String productName;

  @HiveField(2)
  double price;

  @HiveField(3)
  String description;

  @HiveField(4)
  String category;

  @HiveField(5)
  String brand;

  @HiveField(6)
  List<String> images;

  @HiveField(7)
  int discount;

  @HiveField(8)
  int quantity;

  CartProductModel({
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.category,
    required this.brand,
    required this.images,
    required this.discount,
    this.quantity = 1,
  });
}

