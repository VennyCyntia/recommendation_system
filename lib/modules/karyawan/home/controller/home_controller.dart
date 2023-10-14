import 'package:get/get.dart';
import 'package:recommendation_system/app/models/m_menu.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';

class HomeController extends GetxController {
  var cartController = Get.find<CartController>();
  var restaurantController = Get.find<RestaurantController>();

  @override
  void onInit() {
    onSetUpMenu(menu: menu);
    super.onInit();
  }

  void onSetUpMenu({required List<Map<String, Object>> menu}){
    restaurantController.lsRestaurantMenu.clear();
    for(var item in menu){
      restaurantController.lsRestaurantMenu.add(Restaurant.fromJson(item));
    }
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