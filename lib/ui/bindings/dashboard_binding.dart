import 'package:get/get.dart';
import 'package:shopping_app/ui/bindings/app_binding.dart';
import 'package:shopping_app/ui/bindings/product_binding.dart';
import 'package:shopping_app/ui/controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut( ()=> DashboardController());//inject DashboardController : dependency injection

   ProductBinding().dependencies();
   AppBinding().dependencies();
  }

}