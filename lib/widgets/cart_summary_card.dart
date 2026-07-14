import 'package:flutter/material.dart';

class CartSummaryCard extends StatelessWidget {
  final double totalPrice;
  final double totalDiscount;

  const CartSummaryCard({super.key, required this.totalPrice, required this.totalDiscount});

  @override
  Widget build(BuildContext context) {
    final orderTotal = totalPrice - totalDiscount;

    return Card(
      margin: const EdgeInsets.all(12),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Price Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Product Price:"),
                Text("\$${totalPrice.toStringAsFixed(2)}"),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Discount:"),
                Text(
                  "- \$${totalDiscount.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order Total:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${orderTotal.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
