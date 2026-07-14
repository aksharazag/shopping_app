import 'package:get/get.dart';

class DashboardController extends GetxController{
  var selectedIndex = 0.obs;//selectedIndex is reactive (RxInt) → UI updates automatically when changed.

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}