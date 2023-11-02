import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:recommendation_system/app/config/assets_config.dart';
import 'package:recommendation_system/app/config/session_manager.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class DialogConfig {
  onShowBasicLoading() {
    return Get.dialog(WillPopScope(
        child: Center(
          child: SizedBox(
            width: Get.size.width * 0.5,
            height: Get.size.height * 0.5,
            child: Lottie.asset(AssetsConfig.loadingCircle, repeat: true),
          ),
        ),
        onWillPop: () async => false));
  }

  onShowLoadingIndicator() {
    return Get.dialog(Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: Colors.red,
          strokeWidth: 10,
          backgroundColor: Colors.grey.shade300,
        ),
      ),
    ));
  }

  showSnackBarInformation(
      {required String title, required String message, required Color color}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }

  onLogoutDialog({required String title, required String content}) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      middleText: content,
      textCancel: 'Tidak',
      onConfirm: () => UserSession().onRemoveWhenLogout(),
    );
  }

  onShowDialogInformation({required String title, required String content}) {
    Get.defaultDialog(
      barrierDismissible: false,
      title: title.toUpperCase(),
      titleStyle: ThemeConfig().textHeader4(color: ThemeConfig.justWhite),
      middleText: content,
      textConfirm: 'OK',
      middleTextStyle: ThemeConfig().textHeader4(color: ThemeConfig.justWhite),
      backgroundColor: ThemeConfig.darkRed,
      buttonColor: ThemeConfig.justBlack,
      confirmTextColor: ThemeConfig.justWhite,
      onConfirm: () => Get.back(),
    );
  }
}
