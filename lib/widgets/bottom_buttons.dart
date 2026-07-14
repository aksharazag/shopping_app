import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/product_details_controller.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Add to Cart (Outlined)
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                controller.addToCart(); // controller logic
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.deepOrange),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // adjust the radius as needed
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart,color: Colors.deepOrange,size: 30,),
                  const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Buy Now (Filled)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                controller.buyNow(); // controller logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4), // adjust the radius as needed
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(Icons.play_arrow_sharp,color: Colors.white,size: 30,),
                  const Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
