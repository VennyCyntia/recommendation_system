import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/session_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var id = 0.obs;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no_telp = TextEditingController();
  TextEditingController preference = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await onGetUserInformation();
    super.onInit();
  }

  Future<void> onGetUserInformation() async {
    id.value = await UserSession().onGetId();
    print('id restaurant '+id.toString());
    username.text = await UserSession().onGetUsername();
    email.text = await UserSession().onGetEmail();
    no_telp.text = await UserSession().onGetNoTelepon();
    preference.text = await UserSession().onGetNoTelepon();
  }

}