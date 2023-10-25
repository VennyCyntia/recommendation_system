import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/config/session_manager.dart';
import 'package:recommendation_system/app/models/user_information.dart';
import 'package:recommendation_system/routes/app_routes.dart';

class LoginController extends GetxController {
  var formLoginKey = GlobalKey<FormState>();
  var currentIndex = 0.obs;
  var isRestaurant = false.obs;
  var isHidePassword = true.obs;

  var isLoading = false.obs;

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  void selectedItems(int index) {
    switch (index) {
      case 0:
        currentIndex.value = index;
        break;
      case 1:
        onToOrderContainer();
        break;
      case 2:
        onToCartContainer();
        break;
      case 3:
        onToProfileContainer();
        break;
    }
  }

  void onToOrderContainer() {
    Get.toNamed(AppRoutes.order);
  }

  void onToCartContainer() {
    Get.toNamed(AppRoutes.cart);
  }

  void onToProfileContainer() {
    Get.toNamed(AppRoutes.profile);
  }

  onShowPassVisibility() {
    isHidePassword.value = !isHidePassword.value;
  }

  Future<void> onValidateUser() async {
    if (formLoginKey.currentState!.validate()) {
      Map body = {
        'username': username.text,
        'password': password.text,
      };
      if (isRestaurant.value == true) {
        String url = '${GlobalUrl.baseUrl}${GlobalUrl.loginRestaurant}';
        var result = await APIConfig()
            .onSendOrGetSource(url: url, methodType: 'POST', body: body);
        Get.back();
        onFilterUserLogin(result: result, type: 'restaurant');
      } else {
        String url = '${GlobalUrl.baseUrl}${GlobalUrl.loginUser}';
        var result = await APIConfig()
            .onSendOrGetSource(url: url, methodType: 'POST', body: body);
        onFilterUserLogin(result: result, type: 'user');
      }
    }
  }

  Future<void> onFilterUserLogin(
      {required String result, required String type}) async {
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {
      print('gagal woi');
    } else {
      var data = json.decode(result);
      if (type == 'restaurant') {
        print('item '+data.toString());
        RestaurantInformation restData = RestaurantInformation.fromJson(data);
        await UserSession().onSetRestaurantInformation(data: restData);
        Get.toNamed(AppRoutes.restaurant);
      } else if (data['role'] == 'employee') {
        UserInformation userData = UserInformation.fromJson(data);
        await UserSession().onSetUserInformation(data: userData);
        Get.toNamed(AppRoutes.employeeMain);
      } else {
        UserInformation userData = UserInformation.fromJson(data);
        await UserSession().onSetUserInformation(data: userData);
        Get.toNamed(AppRoutes.admin);
      }
    }
  }

// Future<void> onSetUserInformation() async {}
}
