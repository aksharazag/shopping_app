// lib/presentation/widgets/appbar_menu.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/widgets/cart_badge.dart';

import '../ui/controllers/auth_controller.dart';
import '../ui/controllers/cart_controller.dart';
import '../ui/screens/profile_screen.dart';

class AppBarMenu extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBarMenu({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    return AppBar(
      backgroundColor: Colors.lightGreen.shade50,
      automaticallyImplyLeading: false,
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.orange,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      leading: PopupMenuButton<String>(
        icon: const Icon(Icons.menu, color: Colors.green),
        onSelected: (value) {
          final authController = Get.find<AuthController>();
          switch (value) {
            case 'Profile':
              Get.toNamed('/profile', arguments: {'email': authController.currentUser.value?.email});
              break;
            case 'Feedback':
              Get.snackbar("Info", "Coming soon!");
              break;

            case 'Settings':
              Get.snackbar("Info", "Coming soon!");
              break;

            case 'Logout':
              authController.logout();
              break;
          }
          // Add your navigation logic here
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'Profile', child: Text('Profile')),
          PopupMenuItem(value: 'Feedback', child: Text('Feedback')),
          PopupMenuItem(value: 'Settings', child: Text('Settings')),
          PopupMenuItem(
            value: 'Logout',
            child: Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      actions: [
        // Cart Icon with click
        // IconButton(
        //   icon: const Icon(Icons.shopping_cart, color: Colors.green),
        //   onPressed: () {
        //     Get.toNamed('/cart'); // navigate to cart screen
        //   },
        // ),
        CartBadge(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
