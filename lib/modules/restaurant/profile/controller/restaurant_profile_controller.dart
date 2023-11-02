import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/config/session_manager.dart';

class RestaurantProfileController extends GetxController {
  var id = 0.obs;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no_telp = TextEditingController();

  TextEditingController balance = TextEditingController();
  var walletId = ''.obs;
  
  var isLoading = false.obs;

  @override
  onInit() async {
    isLoading.value = true;
    await onGetUserInformation().then((value) async => await onGetBalance(wallet_id: walletId.value));
    super.onInit();
  }

  Future<void> onGetUserInformation() async {
    id.value = await UserSession().onGetId();
    username.text = await UserSession().onGetUsername();
    email.text = await UserSession().onGetEmail();
    no_telp.text = await UserSession().onGetNoTelepon();
    walletId.value = await UserSession().onGetWalletId();
    print('walletid '+walletId.value.toString());
  }

  Future<void> onGetBalance({required String wallet_id}) async {
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