import 'package:get/get.dart';
import 'package:shopping_app/domain/usecases/calculate_cart_totals_usecase.dart';

import '../../data/repositories/cart_repository_impl.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/load_cart_usecase.dart';
import '../../domain/usecases/place_order_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';
import 'auth_binding.dart';

class AppBinding extends Bindings {
  @override
  void dependencies()  {
    // Open the Hive box
   // final cartBox = await Hive.openBox<CartProductModel>('cartBox');

    // Put repository
    AuthBinding().dependencies();
    final cartRepository = CartRepositoryImpl();
    final orderRepository = OrderRepositoryImpl();

    // UseCases
    final loadCartUseCase = LoadCartUseCase(cartRepository);
    final addToCartUseCase = AddToCartUseCase(cartRepository);
    final removeFromCartUseCase = RemoveFromCartUseCase(cartRepository);
    final placeOrderUseCase = PlaceOrderUseCase(
      cartRepository,
      orderRepository,
    );
    final calculateTotals = CalculateCartTotalUseCase();

    // Put controller with repository dependency
    Get.put<CartController>(
      CartController(
        loadCartUseCase: loadCartUseCase,
        addToCartUseCase: addToCartUseCase,
        removeFromCartUseCase: removeFromCartUseCase,
        placeOrderUseCase: placeOrderUseCase,
        calculateTotals: calculateTotals,
        repository: cartRepository,
      ),
      permanent: true,
    );

    // Order Controller
    Get.put<OrderController>(
      OrderController(placeOrderUseCase),
      permanent: true,
    );
  }
}
