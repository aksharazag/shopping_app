import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../domain/entities/product.dart';

class PriceTagWidget extends StatelessWidget {
  final Product product;

  const PriceTagWidget({
    super.key, required this.product
});

  @override
  Widget build(BuildContext context) {
    // Calculate discounted price
    final discountedPrice =
        (product.price * (100 - (product.discount ?? 0))) / 100;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white,Colors.lightGreen[100]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "\$${discountedPrice.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
          const SizedBox(width: 4),
          Text(
            "\$${product.price.toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 10,
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            "${product.discount}% off",
            style: const TextStyle(fontSize: 10, color: Colors.green),
          ),


        ],
      ),
    );
  }



}