import 'package:get/get.dart';
import 'package:recommendation_system/app/config/session_manager.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';

class RestaurantController extends GetxController {
  var cartController = Get.find<CartController>();
  var lsRestaurantMenu = List<ViewRestaurant>.empty(growable: true).obs;

  // var id = ''.obs;
  // var username = ''.obs;
  // var email = ''.obs;
  // var no_telp = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    // await onGetUserInformation();
    onSetUpMenu(menu: menu);
    super.onInit();
  }

  // Future<void> onGetUserInformation() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   id.value = UserSession().onGetId().toString();
  //   username.value = await UserSession().onGetUsername();
  //   email.value = await UserSession().onGetEmail();
  //   no_telp.value = await UserSession().onGetNoTelepon();
  //
  //   print('username '+username.value);
  //   print('email '+email.value);
  //   print('no_telp '+no_telp.value);
  // }

  void onSetUpMenu({required List<Map<String, Object>> menu}){
    lsRestaurantMenu.clear();
    for(var item in menu){
      lsRestaurantMenu.add(ViewRestaurant.fromJson(item));
    }
  }

  onIncreaseItem(
      {required int indexItem,
        required int indexRestaurant,
        required int indexCategory}) {

    ViewRestaurant currentRestaurant = lsRestaurantMenu[indexRestaurant];
    ViewItemMenu currentMenu = lsRestaurantMenu[indexRestaurant]
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
  }

  onDecreaseItem(
      {required int indexItem,
        required int indexRestaurant,
        required int indexCategory}) {
    ViewRestaurant currentRestaurant = lsRestaurantMenu[indexRestaurant];
    ViewItemMenu currentMenu = lsRestaurantMenu[indexRestaurant]
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
    ViewRestaurant? currentRestaurant = lsRestaurantMenu[indexRestaurant];
    ViewItemMenu? currentMenu = lsRestaurantMenu[indexRestaurant]
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

  onToMenuContainer(int index, int indexItem, String restaurantName){
    int indexRestaurant = lsRestaurantMenu.indexWhere((item) => item.restaurantName == restaurantName);

    Get.to(() => MenuContainer(index: index, indexCategory: indexItem, indexRestaurant: indexRestaurant));
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