// lib/presentation/screens/main_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/ui/screens/cart_screen.dart';
import 'package:shopping_app/ui/screens/order_screen.dart';
import '../../widgets/appbar_menu.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../bindings/dashboard_binding.dart';
import '../controllers/dashboard_controller.dart';

import 'product_screen.dart';

class MainDashBoardScreen extends StatelessWidget {
  const MainDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize DashboardBinding
    DashboardBinding().dependencies();

    final controller = Get.find<DashboardController>();

    // Screens list
    final List<Widget> screens = [
      ProductScreen(),
      const Center(child: Text('Category Screen coming soon')),
     // CartScreen(),
     OrderScreen(),

    ];

    return Scaffold(

      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: const DashboardBottomNavBar(),
    );
  }
}
