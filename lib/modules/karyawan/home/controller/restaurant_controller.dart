import 'dart:convert';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/restaurant_page.dart';
import 'package:recommendation_system/modules/restaurant/profile/controller/profile_controller.dart';

class RestaurantController extends GetxController {
  var cartController = Get.find<CartController>();
  var restaurantDetail = ViewDetailRestaurant().obs;
  var lsRestaurantMenu = List<ViewDetailRestaurant>.empty(growable: true).obs;
  var lsRestaurant = List<ViewRestaurant>.empty(growable: true).obs;
  var lsQty = List<dynamic>.empty(growable: true).obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    onSetUpMenu();
    super.onInit();
  }

  Future<void> onSetUpMenu() async {
    lsRestaurant.clear();
    String url = GlobalUrl.baseUrl + GlobalUrl.getAllRestaurant;
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = jsonDecode(result);

    for(var item in data){
      lsRestaurant.add(ViewRestaurant.fromJson(item));
    }
  }

  Future<void> onGetRestaurantDetail({required int id, required int index}) async {
    try{
      String url = GlobalUrl.baseUrl + GlobalUrl.getAllRestaurantData + id.toString();
      var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
      var data = jsonDecode(result);
      restaurantDetail.value = ViewDetailRestaurant.fromJson(data);
    }catch(e){

    }
    Get.to(() => RestaurantPage(id: id, index: index));
  }

  onIncreaseItem(
      {required int indexItem,
        required int id,
        required int indexCategory}) {

    ViewDetailRestaurant currentRestaurant = restaurantDetail.value;
    ViewItemMenu currentMenu = restaurantDetail.value
        .menu![indexCategory].item_menu![indexItem];

    ItemCartRestaurant? restaurantCart = cartController.lsItemCart
        .firstWhereOrNull(
            (item) => item.restaurantName == currentRestaurant.restaurant_name);
    currentMenu.menu_qty = currentMenu.menu_qty! + 1;

    if (restaurantCart != null) {
      ItemCartMenu menuCart = restaurantCart.menu
      !.firstWhere((item) => item.menu_name == currentMenu.menu_name);
      if (menuCart != null) {
        menuCart.menu_qty = currentMenu.menu_qty;
        menuCart.total_price = menuCart.menu_price! * menuCart.menu_qty!;
      }
    }
    onControlTotalPrice();
  }

  onDecreaseItem(
      {required int indexItem,
        required int id,
        required int indexCategory}) {
    ViewDetailRestaurant currentRestaurant = restaurantDetail.value;
    ViewItemMenu currentMenu = restaurantDetail.value
        .menu![indexCategory]
        .item_menu![indexItem];

    currentMenu.menu_qty = currentMenu.menu_qty! - 1;

    ItemCartRestaurant? restaurantCart = cartController.lsItemCart
        .firstWhereOrNull(
            (item) => item.restaurantName == currentRestaurant.restaurant_name);

    if (restaurantCart != null) {
      if (restaurantCart.menu!.length == 1) {
        cartController.lsItemCart.remove(restaurantCart);
      } else {
        ItemCartMenu menuCart = restaurantCart.menu
        !.firstWhere((item) => item.menu_name == currentMenu.menu_name);
        if (menuCart.menu_qty == 0) {
          restaurantCart.menu?.remove(menuCart);
        } else {
          int basicPrice = menuCart.menu_price!;
          // menuCart.orderQty = currentMenu.qty;
          int totalPrice = basicPrice * menuCart.menu_qty!;
          menuCart.total_price = totalPrice;
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
            int totalItemPrice = restaurantName.menu![j].menu_price! *
                restaurantName.menu![j].menu_qty!;
            sumTotalPrice += totalItemPrice;
          }
        }
        restaurantName.totalPrice = sumTotalPrice;
      }
    }

    cartController.lsItemCart.refresh();
    lsRestaurantMenu.refresh();
    restaurantDetail.refresh();
  }

  onChangeItem(
      {required String type,
        required int indexItem,
        required int id,
        required int indexCategory}) {
    if (type == 'increase') {
      onIncreaseItem(
          indexItem: indexItem,
          id: id,
          indexCategory: indexCategory);
    } else {
      onDecreaseItem(
          indexItem: indexItem,
          id: id,
          indexCategory: indexCategory);
    }
  }

  onAddMenu(
      {required int indexItem,
        required int id,
        required int indexCategory}) {

    ViewDetailRestaurant? currentRestaurant = restaurantDetail.value;
    ViewItemMenu? currentMenu = restaurantDetail.value
        .menu![indexCategory]
        .item_menu![indexItem];

    currentMenu.menu_qty = currentMenu.menu_qty! + 1;

    ItemCartRestaurant? restaurantCart = cartController.lsItemCart
        .firstWhereOrNull(
            (item) => item.restaurantName == currentRestaurant.restaurant_name);
    if (restaurantCart != null) {
      restaurantCart.menu!.add(ItemCartMenu(
          menu_name: currentMenu.menu_name,
          menu_image: currentMenu.menu_image,
          menu_price: currentMenu.menu_price,
          menu_qty: currentMenu.menu_qty,
          total_price: currentMenu.menu_price!)
      );
    } else {
      cartController.lsItemCart.add(ItemCartRestaurant(
        restaurantName: currentRestaurant.restaurant_name,
        menu: [
          ItemCartMenu(
              menu_name: currentMenu.menu_name,
              menu_image: currentMenu.menu_image,
              menu_price: currentMenu.menu_price,
              menu_qty: currentMenu.menu_qty,
              total_price: currentMenu.menu_price!)
        ],
      ));
    }
    cartController.lsCheckBox.add(false);

    onControlTotalPrice();
  }

  onToMenuContainer(int index, int indexItem, String restaurantName){
    int indexRestaurant = lsRestaurantMenu.indexWhere((item) => item.restaurant_name == restaurantName);

    // Get.to(() => MenuContainer(index: index, indexCategory: indexItem, indexRestaurant: indexRestaurant));
  }

  var menu = [
    {
      'pic': "https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg",
      'restaurantName': "Noodlelicious",
      'menu': [
        {
          'category': "Noodles",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Premium',
              'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Classic',
              'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
          ]
        },
        {
          'category': "Condiment",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Classic',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            }
          ]
        },
        {
          'category': "Drink",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 20000,
              'qty': 0,
            }
          ]
        }
      ]
    },
    {
      'pic': "https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg",
      'restaurantName': "Manggang",
      'menu': [
        {
          'category': "Noodles",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Classic',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
          ]
        },
        {
          'category': "Condiment",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Classic',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            }
          ]
        },
        {
          'category': "Drink",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 19000,
              'qty': 0,
            }
          ]
        }
      ]
    },
    {
      'pic': "https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg",
      'restaurantName': "Taichan",
      'menu': [
        {
          'category': "Noodles",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Classic',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
          ]
        },
        {
          'category': "Condiment",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Classic',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            }
          ]
        },
        {
          'category': "Drink",
          'itemMenu': [
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            },
            {
              'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
              'title': 'Mie Oven Iga Bakar Premium',
              'subtitle':
              'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
              'price': 18000,
              'qty': 0,
            }
          ]
        }
      ]
    },
  ].obs;
}