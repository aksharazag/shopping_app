import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/appbar_menu.dart';
import '../../widgets/product_card.dart';
import '../controllers/product_controller.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBarMenu(title:"Products"),
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.products.isEmpty) {
          return const Center(child: Text("No products available."));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(6),
          itemCount: controller.products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return ProductCard(product: product);
          },
        );
      }),
    );
  }
}
