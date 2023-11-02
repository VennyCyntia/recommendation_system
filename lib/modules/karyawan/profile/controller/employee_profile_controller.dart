import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/config/session_manager.dart';

class EmployeeProfileController extends GetxController {
  var id = 0.obs;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no_telp = TextEditingController();
  TextEditingController preference = TextEditingController();
  TextEditingController balance = TextEditingController();

  //top up balance
  TextEditingController amount = TextEditingController();
  var walletId = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await onGetUserInformation().then((value) => onGetBalance());
    super.onInit();
  }

  Future<void> onGetUserInformation() async {
    id.value = await UserSession().onGetId();
    username.text = await UserSession().onGetUsername();
    email.text = await UserSession().onGetEmail();
    no_telp.text = await UserSession().onGetNoTelepon();
    preference.text = await UserSession().onGetPreference();
    walletId.value = await UserSession().onGetWalletId();
  }

  Future<void> onTopUpWallet() async {
    String result = 'error';

    Map body = {
      "Amount": amount.text
    };

    String url = GlobalUrl.topUpWallet;
    result = await APIConfig().onSendOrGetSource(
        url: url,
        body: body,
        wallet_id: walletId.value,
        methodType: 'POST',
        headerType: 'setWallet');
    if (result.toLowerCase().contains('failed')) {
      print('gagal ges');
    }else{
      amount.clear();
      await onGetBalance().then((value) => Get.back());
    }
  }

  Future<void> onGetBalance() async {
    String result = 'error';
    String url = GlobalUrl.getWallet;
    result = await APIConfig().onSendOrGetSource(
        url: url,
        wallet_id: walletId.value,
        methodType: 'GET',
        headerType: 'setWallet');
    
    var data= jsonDecode(result);
    balance.text = data['Balance'].toString();
  }

}