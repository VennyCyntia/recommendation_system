import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogConfig {
  showSnackBarInformation({required String title, required String message, required Color color}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }
}
