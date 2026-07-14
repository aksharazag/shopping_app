import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/cart_controller.dart';

class CartBadge extends StatelessWidget {
  final Color iconColor;

  const CartBadge({super.key, this.iconColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final count = cartController.cartItems.length;

      return Stack(
        alignment: Alignment.topRight,
        children: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: iconColor),
            onPressed: () => Get.toNamed('/cart'),
          ),
          if (count > 0)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      );
    });
  }
}
