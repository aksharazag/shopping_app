// lib/presentation/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ui/controllers/dashboard_controller.dart';

class DashboardBottomNavBar extends StatelessWidget {
  const DashboardBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return Obx(
          () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lightGreen.shade50,
        selectedItemColor: Colors.orange.shade600,
        unselectedItemColor: Colors.green,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category_outlined), label: 'Categories'),
          //BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.update_outlined), label: 'Orders'),
        ],
      ),
    );
  }
}
