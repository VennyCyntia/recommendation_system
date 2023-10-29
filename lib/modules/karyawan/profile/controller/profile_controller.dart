import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/session_manager.dart';

class ProfileController extends GetxController {
  var id = 0.obs;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no_telp = TextEditingController();
  TextEditingController preference = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() async {
    print('profile njih');
    isLoading.value = true;
    await onGetUserInformation();
    super.onInit();
  }

  Future<void> onGetUserInformation() async {
    id.value = await UserSession().onGetId();
    username.text = await UserSession().onGetUsername();
    email.text = await UserSession().onGetEmail();
    no_telp.text = await UserSession().onGetNoTelepon();
    preference.text = await UserSession().onGetNoTelepon();
  }

}