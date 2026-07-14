import 'package:get/get.dart';
import '../../data/models/order_model_hive.dart';
import '../../domain/usecases/place_order_usecase.dart';
import 'auth_controller.dart';

class OrderController extends GetxController {
 // final OrderRepository repository;

  var orders = <OrderModelHive>[].obs;
  final PlaceOrderUseCase placeOrderUseCase;

  OrderController(this.placeOrderUseCase);




  @override
  void onInit() {
    super.onInit();
    final authController = Get.find<AuthController>();

    // React when user logs in or logs out
    ever(authController.currentUser, (user) {
      if (user != null) {
        loadOrders(); // only when user is set
      } else {
        orders.clear();
      }
    });

    //loadOrders();
  }

  Future<void> loadOrders() async {
    final userId = Get.find<AuthController>().currentUser.value!.email;
    orders.assignAll(await placeOrderUseCase.orderRepository.getOrders(userId));
    print("Loaded orders: ${orders.length}");
  }
}
