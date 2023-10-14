import 'package:get/get.dart';
import 'package:recommendation_system/app/models/m_menu.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';

class RestaurantController extends GetxController {
  var cartController = Get.find<CartController>();
  var lsRestaurantMenu = List<Restaurant>.empty(growable: true).obs;

  onIncreaseItem(
      {required int indexItem,
        required int indexRestaurant,
        required int indexCategory}) {

    Restaurant currentRestaurant = lsRestaurantMenu[indexRestaurant];
    ItemMenu currentMenu = lsRestaurantMenu[indexRestaurant]
        .menu![indexCategory].itemMenu![indexItem];

    ItemCartRestaurant? restaurantCart = cartController.lsItemCart
        .firstWhereOrNull(
            (item) => item.restaurantName == currentRestaurant.restaurantName);
    currentMenu.qty = currentMenu.qty! + 1;

    if (restaurantCart != null) {
      ItemCartMenu menuCart = restaurantCart.menu
      !.firstWhere((item) => item.title == currentMenu.title);
      if (menuCart != null) {
        menuCart.orderQty = currentMenu.qty;
        menuCart.totalprice = menuCart.price! * menuCart.orderQty!;
      }
    }
    onControlTotalPrice();
    // cartController.lsItemCart.refresh();
    // lsRestaurantMenu.refresh();
  }

  onDecreaseItem(
      {required int indexItem,
        required int indexRestaurant,
        required int indexCategory}) {
    Restaurant currentRestaurant = lsRestaurantMenu[indexRestaurant];
    ItemMenu currentMenu = lsRestaurantMenu[indexRestaurant]
        .menu![indexCategory]
        .itemMenu![indexItem];

    currentMenu.qty = currentMenu.qty! - 1;

    ItemCartRestaurant? restaurantCart = cartController.lsItemCart
        .firstWhereOrNull(
            (item) => item.restaurantName == currentRestaurant.restaurantName);

    if (restaurantCart != null) {
      if (restaurantCart.menu!.length == 1) {
        cartController.lsItemCart.remove(restaurantCart);
      } else {
        ItemCartMenu menuCart = restaurantCart.menu
        !.firstWhere((item) => item.title == currentMenu.title);
        if (menuCart.orderQty == 0) {
          restaurantCart.menu?.remove(menuCart);
        } else {
          int basicPrice = menuCart.price!;
          menuCart.orderQty = currentMenu.qty;
          int totalPrice = basicPrice * menuCart.orderQty!;
          menuCart.totalprice = totalPrice;
        }
      }
    }
    onControlTotalPrice();
  }

  void onControlTotalPrice() {
    int sumTotalPrice = 0;

    if (cartController.lsItemCart.isNotEmpty) {
      for (int i = 0; i < cartController.lsItemCart.length; i++) {
        ItemCartRestaurant restaurantName = cartController.lsItemCart[i];
        sumTotalPrice = 0;
        if (restaurantName.menu != null) {
          for(int j = 0; j < restaurantName.menu!.length; j++) {
            int totalItemPrice = restaurantName.menu![j].price! *
                restaurantName.menu![j].orderQty!;
            sumTotalPrice += totalItemPrice;
          }
        }
        restaurantName.totalPrice = sumTotalPrice;
      }
    }

    cartController.lsItemCart.refresh();
    lsRestaurantMenu.refresh();
  }

  onChangeItem(
      {required String type,
        required int indexItem,
        required int indexRestaurant,
        required int indexCategory}) {
    if (type == 'increase') {
      onIncreaseItem(
          indexItem: indexItem,
          indexRestaurant: indexRestaurant,
          indexCategory: indexCategory);
    } else {
      onDecreaseItem(
          indexItem: indexItem,
          indexRestaurant: indexRestaurant,
          indexCategory: indexCategory);
    }
  }

  onAddMenu(
      {required int indexItem,
        required int indexRestaurant,
        required int indexCategory}) {
    Restaurant? currentRestaurant = lsRestaurantMenu[indexRestaurant];
    ItemMenu? currentMenu = lsRestaurantMenu[indexRestaurant]
        .menu![indexCategory]
        .itemMenu![indexItem];

    currentMenu.qty = currentMenu.qty! + 1;

    ItemCartRestaurant? restaurantCart = cartController.lsItemCart
        .firstWhereOrNull(
            (item) => item.restaurantName == currentRestaurant.restaurantName);
    if (restaurantCart != null) {
      restaurantCart.menu!.add(ItemCartMenu(
          title: currentMenu.title,
          pic: currentMenu.pic,
          price: currentMenu.price,
          orderQty: currentMenu.qty,
          totalprice: currentMenu.price!));
    } else {
      cartController.lsItemCart.add(ItemCartRestaurant(
        restaurantName: currentRestaurant.restaurantName,
        menu: [
          ItemCartMenu(
              title: currentMenu.title,
              pic: currentMenu.pic,
              price: currentMenu.price,
              orderQty: currentMenu.qty,
              totalprice: currentMenu.price!)
        ],
      ));
    }
    cartController.lsCheckBox.add(false);

    onControlTotalPrice();
  }
}