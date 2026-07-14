import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/widgets/appbar_menu.dart';
import '../controllers/order_controller.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    return Scaffold(
      appBar: AppBarMenu(title:"My orders"),
      body: Obx(() {
        if (controller.orders.isEmpty) {
          return const Center(child: Text("No orders placed yet."));
        }

        return ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, index) {
            final order = controller.orders[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🖼 Left side image
                    if (order.items.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          order.items[0].images.isNotEmpty
                              ? order.items[0].images[0]
                              : 'https://via.placeholder.com/150',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 100),
                        ),
                      ),

                    const SizedBox(width: 12),

                    // 🛒 Right side column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product names & prices
                          ...order.items.map(
                            (p) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${p.productName}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "\$${p.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
