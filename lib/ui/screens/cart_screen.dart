import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/CartItemCard.dart';
import '../../widgets/cart_summary_card.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    // Load cart only once when screen opens
    controller.loadCart();

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.lightGreen.shade50,
      ),
      body: Obx(() {
        final items = controller.cartItems;
        if (items.isEmpty) return const Center(child: Text("Cart is empty"));

        return ListView.builder(
          itemCount: controller.cartItems.length + 1,
          itemBuilder: (_, index) {
            if (index < controller.cartItems.length) {
              return CartItemCard(
                product: controller.cartItems[index],
                controller: controller,
              );
            } else {
              return CartSummaryCard(
                totalPrice: controller.totalPrice,
                totalDiscount: controller.totalDiscount,
              );
            }
          },
        );
      }),

      // ✅ Bottom Nav with Text + Button
      bottomNavigationBar: Obx(() {
        final items = controller.cartItems;
        if (items.isEmpty) return const SizedBox.shrink();


        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "\$${controller.finalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange, // fill color
                  foregroundColor: Colors.white, // text color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 46,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius
                        .zero, // pure rectangle (no rounded corners)
                  ),
                ),
                onPressed: () async {
                  await controller.placeOrder();
                  // // Refresh the order screen data
                  // final orderController = Get.find<OrderController>();
                  // await orderController.loadOrders();

                  // Get.toNamed('/orders');

                  Get.defaultDialog(
                    title: "Order Successful 🎉",
                    middleText: "Your order has been placed!",
                    textConfirm: "OK",
                    onConfirm: () =>{
                      Get.back(),
                    Get.offNamed('/orders'), 
                    },

                  );

                  // Get.snackbar("Continue", "Ordered Successfully",backgroundColor: Colors.white,colorText: Colors.deepOrange,);
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
