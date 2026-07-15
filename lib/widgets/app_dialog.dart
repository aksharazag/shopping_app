import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static void show({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = "OK",
   
  }) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: confirmText,
      
      confirmTextColor: Colors.white,
      buttonColor: Colors.deepOrange,
      onConfirm: onConfirm,
    );
  }
}