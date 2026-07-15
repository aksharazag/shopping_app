import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/load_cart_usecase.dart';
import '../../domain/usecases/place_order_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/calculate_cart_totals_usecase.dart';

import 'auth_controller.dart';
import 'order_controller.dart';

class CartController extends GetxController {
  final LoadCartUseCase loadCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final PlaceOrderUseCase placeOrderUseCase;

  final CalculateCartTotalUseCase calculateTotals;
  final CartRepository repository;

  var cartItems = <Product>[].obs;

  CartController({
    required this.loadCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.placeOrderUseCase,
    required this.calculateTotals,
    required this.repository,
  });
  double get totalPrice => calculateTotals.getTotalPrice(cartItems);
  double get totalDiscount => calculateTotals.getTotalDiscount(cartItems);
  double get finalPrice => calculateTotals.afterDiscountPrice(cartItems);

  @override
  void onInit() {
    super.onInit();

    // Observe currentUser
    ever(Get.find<AuthController>().currentUser, (user) {
      if (user != null && user.email.isNotEmpty) {
        loadCart();
      }
    });
  }

  Future<void> loadCart() async {
    final user = Get.find<AuthController>().currentUser.value;
    if (user == null) return;

    cartItems.assignAll(await loadCartUseCase(user.email)); // triggers Obx
    printCart();
  }

  Future<void> addProduct(Product product) async {
    final user = Get.find<AuthController>().currentUser.value;
    if (user == null || user.email.isEmpty) return;

    //await repository.addToCart(user.email, product);
    await addToCartUseCase(user.email, product);
    await loadCart();

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text("${product.productName} added successfully")),
    );
  }

  Future<void> removeFromCart(Product product) async {
    final user = Get.find<AuthController>().currentUser.value;
    if (user == null || user.email.isEmpty) return;

    //await repository.removeFromCart(user.email, product);
    await removeFromCartUseCase(user.email, product);
    await loadCart(); // refresh after removing
  }

  Future<void> placeOrder() async {
    final user = Get.find<AuthController>().currentUser.value;
    if (user == null || user.email.isEmpty) return;

    await placeOrderUseCase(user.email);
    // Refresh orders
    final orderController = Get.find<OrderController>();
    await orderController.loadOrders();

    cartItems.clear();
  }

  Future<void> clearCart() async {
    final user = Get.find<AuthController>().currentUser.value;
    if (user == null || user.email.isEmpty) return;
    await repository.clearCart(user.email);
  }

  void increaseQuantity(Product product) {
    int index = cartItems.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      cartItems[index].quantity = cartItems[index].quantity! + 1;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(Product product) {
    int index = cartItems.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      if (cartItems[index].quantity! == 1) {
        removeFromCart(product);
      } else {
        cartItems[index].quantity = cartItems[index].quantity! - 1;
        cartItems.refresh();
      }
    }
  }

  int get count => cartItems.length;

  void printCart() {
    print("===== Cart Items =====");
    for (var item in cartItems) {
      print("${item.productName} - \$${item.price}");
      print(item.quantity);
    }
  }
}
