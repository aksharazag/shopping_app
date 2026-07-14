import 'package:flutter/material.dart';
import '../ui/controllers/cart_controller.dart';

class CartActionRow extends StatelessWidget {
  final product;
  final CartController controller;

  const CartActionRow({super.key, required this.product, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                right: BorderSide(color: Colors.grey, width: 1),
                left: BorderSide(color: Colors.transparent, width: 1),
                bottom: BorderSide(color: Colors.transparent, width: 1),
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                print("Move to Wishlist clicked");
              },
              child: const Text(
                "Move to Wishlist",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                left: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.transparent, width: 1),
              ),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                controller.removeFromCart(product);
                print("Remove clicked");
              },
              child: const Text(
                "Remove",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
