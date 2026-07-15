import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_app/ui/bindings/app_binding.dart';
import 'package:shopping_app/ui/bindings/auth_binding.dart';
import 'package:shopping_app/ui/bindings/product_binding.dart';
import 'package:shopping_app/ui/bindings/product_details_binding.dart';
import 'package:shopping_app/ui/bindings/profile_binding.dart';
import 'package:shopping_app/ui/screens/cart_screen.dart';
import 'package:shopping_app/ui/screens/main_dash_board_screen.dart';
import 'package:shopping_app/ui/screens/order_screen.dart';
import 'package:shopping_app/ui/screens/product_details_screen.dart';
import 'package:shopping_app/ui/screens/product_screen.dart';
import 'package:shopping_app/ui/screens/profile_screen.dart';
import 'data/models/cart_product_model_hive.dart';
import 'data/models/order_model_hive.dart';
import 'data/models/product_model_hive.dart';

import 'data/models/profile_model_hive.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(ProductModelHiveAdapter());
  Hive.registerAdapter(ProfileModelHiveAdapter());
  await Hive.openBox<ProductModelHive>('productsBox');

  Hive.registerAdapter(CartProductModelAdapter());
  Hive.registerAdapter(OrderModelHiveAdapter()); // register
  await Hive.openBox<CartProductModel>('cartBox'); // open cartBox

  await Hive.openBox<OrderModelHive>('ordersBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Auth App',
      // initialBinding: AuthBinding(),
      initialBinding: AppBinding(),
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/register',
          page: () => RegisterScreen(),
          binding: AuthBinding(),
        ),
        GetPage(name: '/home', page: () => MainDashBoardScreen()),
        GetPage(
          name: '/product',
          page: () => ProductScreen(),
          binding: ProductBinding(),
        ),
        GetPage(
          name: '/product-details',
          page: () => const ProductDetailsScreen(),
          binding: ProductDetailsBinding(),
        ),
        GetPage(name: '/cart', page: () => CartScreen()),

        GetPage(
          name: '/orders',
          page: () => const OrderScreen(),
          binding: AppBinding(),
        ),
        GetPage(
          name: '/profile',
          page: () => ProfileScreen(),
          binding: ProfileBinding()

        ),

      ],
    );
  }
}
