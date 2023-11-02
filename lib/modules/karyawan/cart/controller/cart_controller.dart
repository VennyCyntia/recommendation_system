import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/Routes/app_routes.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_checkout_container.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_confirmation_container.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/employee_profile_controller.dart';

class CartController extends GetxController {
  var profileController = Get.put(EmployeeProfileController());

  var lsItemCart = List<ItemCartRestaurant>.empty(growable: true).obs;
  var lsTotalPrice = List<dynamic>.empty(growable: true).obs;

  var lsCheckOutItem = ItemCartRestaurant();
  var totalPrice = 0.obs;

  var lsNotes = List<TextEditingController>.empty(growable: true).obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await profileController.onGetUserInformation();
    await onGetAllData();
    super.onInit();
  }

  Future<void> onGetAllData() async {
    lsItemCart.clear();

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.getItem}${profileController.id.value}';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'GET');
    log(result);
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
          wallet_id: restaurant.wallet_id,
          menu: currentMenu);

      Get.to(() => CheckoutContainer());
    } else {
      DialogConfig().showSnackBarInformation(
          title: 'Error', message: 'No item selected', color: Colors.red);
    }
  }

  Future<void> onCreateBill() async {
    Map createBill = {
      "MerchantTransId": lsCheckOutItem.restaurant_name!.substring(0,3)+"-0000"+lsCheckOutItem.restaurant_id.toString(),
      "Amount": totalPrice.value,
      "ExpireMinutes": "30",
      "TransInfo": "",
      "ItemsInfo": ""
    };

    String url = GlobalUrl.createBill;
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: createBill,  headerType: "setWallet", wallet_id: lsCheckOutItem.wallet_id);
    var data = jsonDecode(result);

    if (result.toLowerCase().contains('failed')) {
      print('gagal ges');
    }else{
      onPlaceOrder(order_id: data['TransId']);
    }

  }

  Future<void> onPlaceOrder({required String order_id}) async {
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
      "order_id" : order_id,
      "wallet_id": lsCheckOutItem.wallet_id,
      "restaurant_id" : lsCheckOutItem.restaurant_id,
      "user_id" : profileController.id.value,
      "total_price" : totalPrice.value,
      "menu" : listMenu,
    };
    log(jsonEncode(body));

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.createOrder}';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: body);
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    }else{
      await onDeleteMenu(restaurant: lsCheckOutItem.restaurant_id!);
      Get.to(() => const ConfirmationContainer());
    }
  }

  Future<void> onDeleteMenu({required int restaurant}) async {
    List<int> menuId = [];
    for(int i=0; i<lsCheckOutItem.menu!.length; i++){
      menuId.add(lsCheckOutItem.menu![i].menu_id!);
    }

    Map body = {
      "list_menu": menuId
    };

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.deleteCartItem}';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: body);

    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    }else{

    }
  }

  onRefreshData() async {
    Get.until((route) => Get.currentRoute == AppRoutes.employeeMain);
    await Get.find<RestaurantController>().onSetUpMenu();
    await onGetAllData();
  }
}
