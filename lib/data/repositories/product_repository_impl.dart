import 'package:hive/hive.dart';

import '../../core/network/api_client.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model_hive.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiClient apiClient;
  final Box<ProductModelHive> productBox;

  ProductRepositoryImpl({required this.apiClient, required this.productBox});

  @override
  Future<List<Product>> getProducts() async {
    try {
      final data = await apiClient.get('/products');
      final products = (data as List).map((json) => ProductModelHive.fromJson(json)).toList();

      // Save locally
      await productBox.clear();//clear old cache
      await productBox.addAll(products);//save new data

      return products;
    } catch (e) {
      // If network fails, return cached products
      if (productBox.isNotEmpty) {
        return productBox.values.toList();
      }
      rethrow; // No network & no cache
    }
  }

  @override
  Future<Product> getProductById(String productId) async {
    try {
      final productModel = productBox.values
          .firstWhere((p) => p.id == productId, orElse: () => throw Exception("Product not found"));

      return productModel.toDomain(); // convert Hive model to Product entity
    } catch (e) {
      throw Exception("Product not found");
    }
  }


}
