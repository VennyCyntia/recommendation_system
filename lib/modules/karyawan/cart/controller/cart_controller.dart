import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_checkout_container.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_confirmation_container.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/profile_controller.dart';

class CartController extends GetxController {
  var profileController = Get.find<ProfileController>();

  var lsItemCart = List<ItemCartRestaurant>.empty(growable: true).obs;
  var lsTotalPrice = List<dynamic>.empty(growable: true).obs;

  var lsCheckOutItem = ItemCartRestaurant();
  var totalPrice = 0.obs;

  var lsNotes = List<TextEditingController>.empty(growable: true).obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    onGetAllData();
    log('id '+profileController.id.value.toString());
    super.onInit();
  }

  Future<void> onGetAllData() async {
    lsItemCart.clear();
    String url = '${GlobalUrl.baseUrl}${GlobalUrl.getItem}${profileController.id.value}';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'GET');
    var data = jsonDecode(result);
    for(var item in data){
      lsItemCart.add(ItemCartRestaurant.fromJson(item));
    }

    onControlTotalPrice();
  }

  void onControlTotalPrice() {
    lsTotalPrice.clear();
    int totalPrice = 0;

    for (int i = 0; i < lsItemCart.length; i++) {
      totalPrice = 0;
      var item = lsItemCart[i];
      for (int j = 0; j < item.menu!.length; j++) {
        int price = item.menu![j].menu_price!;
        int subPrice = price * item.menu![j].menu_qty!;
        totalPrice += subPrice;
      }
      lsTotalPrice.add(totalPrice);
    }
  }

  onCheckOutCart({required int indexRestaurant}) {
    totalPrice.value = 0;
    ItemCartRestaurant restaurant = lsItemCart[indexRestaurant];
    List<ItemCartMenu>? menu = lsItemCart[indexRestaurant].menu;

    List<ItemCartMenu>? currentMenu = menu!.where((item) => item.checkbox == true).toList();

    if (currentMenu.isNotEmpty) {
      for (int i = 0; i < currentMenu.length; i++) {
        int price = currentMenu[i].menu_price!;
        int subPrice = price * currentMenu[i].menu_qty!;
        totalPrice += subPrice;
        lsNotes.add(TextEditingController());
      }
      lsCheckOutItem = ItemCartRestaurant(
          restaurant_id: restaurant.restaurant_id,
          restaurant_name: restaurant.restaurant_name,
          menu: currentMenu);

      Get.to(() => CheckoutContainer());
    } else {
      DialogConfig().showSnackBarInformation(
          title: 'Error', message: 'No item selected', color: Colors.red);
    }
  }

  Future<void> onPlaceOrder() async {
    List<Map<String, dynamic>> listMenu = [];
    for(int i=0; i<lsCheckOutItem.menu!.length; i++){
      Map<String, dynamic> menu = {
        "menu_id": lsCheckOutItem.menu![i].menu_id,
        "quantity": lsCheckOutItem.menu![i].menu_qty,
        "notes": lsNotes[i].text
      };
      listMenu.add(menu);
    }

    Map body = {
      "restaurant_id" : lsCheckOutItem.restaurant_id,
      "user_id" : profileController.id.value,
      "total_price" : totalPrice.value,
      "menu" : listMenu,
    };

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.createOrder}';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: body);
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    }else{
      Get.to(() => const ConfirmationContainer());
    }

  }
}
