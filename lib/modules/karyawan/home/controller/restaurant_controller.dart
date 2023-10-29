import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/restaurant_page.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/profile_controller.dart';

class RestaurantController extends GetxController {
  var profileController = Get.put(ProfileController());
  var cartController = Get.find<CartController>();

  var lsRestaurantMenu = List<ViewDetailRestaurant>.empty(growable: true).obs;

  var lsRestaurant = List<ViewRestaurant>.empty(growable: true).obs;
  var restaurantDetail = ViewDetailRestaurant().obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    print(profileController.id.value);
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
    restaurantDetail.value = ViewDetailRestaurant();
    try{
      String url = GlobalUrl.baseUrl + GlobalUrl.getAllRestaurantData + id.toString();
      var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
      var data = await jsonDecode(result);
      restaurantDetail.value = ViewDetailRestaurant.fromJson(data);
      Get.to(() => RestaurantPage(id: id, index: index));
    }catch(e){}
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

  onIncreaseItem(
      {required int indexItem,
        required int id,
        required int indexCategory}) {

    ViewItemMenu currentMenu = restaurantDetail.value
        .menu![indexCategory].item_menu![indexItem];

    currentMenu.menu_qty = currentMenu.menu_qty! + 1;

    restaurantDetail.refresh();
  }

  onDecreaseItem(
      {required int indexItem,
        required int id,
        required int indexCategory}) {
    ViewItemMenu currentMenu = restaurantDetail.value
        .menu![indexCategory]
        .item_menu![indexItem];

    if (currentMenu.menu_qty != 0) {
      currentMenu.menu_qty = currentMenu.menu_qty! - 1;
    }

    restaurantDetail.refresh();
  }

  Future<void> onAddMenu (
      {required int indexItem,
        required int menuId,
        required int indexCategory}) async {

    ViewDetailRestaurant? currentRestaurant = restaurantDetail.value;
    ViewItemMenu currentMenu = restaurantDetail.value
        .menu![indexCategory]
        .item_menu![indexItem];

    Map body = {
      'user_id' : profileController.id.value,
      'restaurant_id' : currentRestaurant.restaurant_id,
      'menu_id' : menuId,
      'quantity' : currentMenu.menu_qty
    };

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.createItem}';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: body);
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {
    }

    await cartController.onGetAllData().then((value) => Future.delayed(Duration.zero, () => Get.back()));
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