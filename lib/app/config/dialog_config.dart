import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recommendation_system/app/config/assets_config.dart';
import 'package:recommendation_system/app/config/session_manager.dart';

class DialogConfig {
  onShowBasicLoading() {
    return Center(
      child: SizedBox(
        height: Get.size.height * 0.2,
        child: Lottie.asset(AssetsConfig.loadingCircle, repeat: true),
      ),
    );
  }

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

  onLogoutDialog({required String title, required String content}){
    Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      middleText: content,
      textCancel: 'Tidak',
      onConfirm: () => UserSession().onRemoveWhenLogout(),
    );
  }


}
