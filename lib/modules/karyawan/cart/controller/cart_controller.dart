import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/app/models/m_menu.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_checkout_container.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';

class CartController extends GetxController {
  var restaurantController = Get.find<RestaurantController>();

  var lsItemCart = List<ItemCartRestaurant>.empty(growable: true).obs;
  var lsCheckOutItem = ItemCartRestaurant();
  var lsCheckBox = List<bool>.empty(growable: true).obs;

  @override
  void onInit() {
    super.onInit();
  }

  onToMenuContainer(int index, int indexItem, String restaurantName){
    int indexRestaurant = restaurantController.lsRestaurantMenu.indexWhere((item) => item.restaurantName == restaurantName);

    Get.to(() => MenuContainer(index: index, indexCategory: indexItem, indexRestaurant: indexRestaurant));
  }

  onCheckOutCart({required int indexRestaurant}) {
    List<int> checkItem = lsCheckBox
        .asMap()
        .entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    ItemCartRestaurant? restaurant = lsItemCart[indexRestaurant];

    List<ItemCartMenu> item = [];
    int totalPrice = 0;
    if (checkItem.isNotEmpty) {
      for (int i = 0; i < checkItem.length; i++) {
        int price = restaurant.menu![checkItem[i]].totalprice!;
        totalPrice += price;
        item.add(restaurant.menu![checkItem[i]]);
      }
      lsCheckOutItem = ItemCartRestaurant(
          restaurantName: restaurant.restaurantName,
          menu: item,
          totalPrice: totalPrice);
      Get.to(() => CheckoutContainer());
    } else {
      DialogConfig().showSnackBarInformation(
          title: 'Error', message: 'No item selected', color: ThemeConfig.justRed);
    }
  }
}
