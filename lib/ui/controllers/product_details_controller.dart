import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/product_details_usecase.dart';
import 'cart_controller.dart';

class ProductDetailsController extends GetxController {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsController(this.getProductDetailsUseCase);

  var product = Rxn<Product>();
  var currentIndex = 0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // read arguments from Get.arguments (set by Get.toNamed)
    final productId = Get.arguments as String;
    loadProduct(productId);
  }

  void loadProduct(String productId) async {
    try {
      isLoading.value = true;
      product.value = await getProductDetailsUseCase(productId);
    } finally {
      isLoading.value = false;
    }
  }

  void changeImage(int index) {
    currentIndex.value = index;
  }

  void addToCart() {
    print("cart clicked");
    if (product.value == null) return;

    final cartController = Get.find<CartController>();
    cartController.addProduct(product.value!);

    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      borderRadius: 0,
      titleText: const SizedBox.shrink(),
      messageText: Text(
        "product is added to cart",
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
    print("Product added to cart!");
  }

  void buyNow() {
    print("buynow clicked");
    if (product.value == null) return;
    final cartController = Get.find<CartController>();
    cartController.addProduct(product.value!);
    Get.toNamed('/cart'); // navigate to cart screen
  }
}
