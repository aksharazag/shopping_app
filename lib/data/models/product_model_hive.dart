// import '../../domain/entities/product.dart';
//
// class ProductModel extends Product {
//   ProductModel({
//     required super.id,
//     required super.productName,
//     required super.price,
//     required super.description,
//     required super.category,
//     required super.brand,
//     required super.images,
//
//   });
//
//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       productName: json['productName'],
//       price: json['price'],
//       description: json['description'],
//       category: json['category'],
//       brand: json['brand'],
//       images: List<String>.from(json['images']),
//
//     );
//   }
// }

import 'package:hive/hive.dart';
import '../../domain/entities/product.dart';

part 'product_model_hive.g.dart';

@HiveType(typeId: 0)
class ProductModelHive extends Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String brand;

  @HiveField(6)
  final List<String> images;

  @HiveField(7)
  final int discount;

  @HiveField(8)
  final int?  quantity;

  ProductModelHive({
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.category,
    required this.brand,
    required this.images,
    required this.discount,
    required this.quantity,
  }) : super(
         id: id,
         productName: productName,
         price: price,
         description: description,
         category: category,
         brand: brand,
         images: images,
    discount: discount,
    quantity: quantity ?? 1,
       );

  Product toDomain() {
    return Product(
      id: id,
      productName: productName,
      price: price,
      description: description,
      images: images,
      category: category,
      brand: brand,
      discount: discount,
      quantity: quantity ?? 1,
    );
  }

  factory ProductModelHive.fromJson(Map<String, dynamic> json) {
    return ProductModelHive(
      id: json['id'],
      productName: json['productName'],
      price: (json['price'] != null ? (json['price'] as num).toDouble() : 0.0),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      discount: json['discount'] != null ? (json['discount'] as num).toInt() : 0,
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      quantity: json['quantity'] != null ? (json['quantity'] as num).toInt() : 1,
    );
  }
}
