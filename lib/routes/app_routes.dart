import 'package:get/get.dart';
import 'package:recommendation_system/Modules/Login/Binding/login_binding.dart';
import 'package:recommendation_system/modules/admin/binding/admin_binding.dart';
import 'package:recommendation_system/modules/admin/pages/admin_container.dart';
import 'package:recommendation_system/modules/karyawan/cart/binding/cart_binding.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_container.dart';
import 'package:recommendation_system/modules/karyawan/home/binding/home_binding.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/home_container.dart';
import 'package:recommendation_system/modules/karyawan/main_container.dart';
import 'package:recommendation_system/modules/karyawan/order/binding/order_binding.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/order_container.dart';
import 'package:recommendation_system/modules/karyawan/profile/pages/profile_container.dart';
import 'package:recommendation_system/modules/login/pages/login_header.dart';
import 'package:recommendation_system/modules/restaurant/binding/restaurant_binding.dart';
import 'package:recommendation_system/modules/restaurant/pages/menu_restaurant_container.dart';
import 'package:recommendation_system/modules/restaurant/pages/order_restaurant_container.dart';
import 'package:recommendation_system/modules/restaurant/pages/profile_restaurant_container.dart';
import 'package:recommendation_system/modules/restaurant/restaurant_main_container.dart';

class AppRoutes{
  static String main = '/main';
  static String login = '/login';
  static String home = '/home';
  static String cart = '/cart';
  static String profile = '/profile';
  static String order = '/order';
  static String restaurant = '/restaurant';
  static String admin = '/admin';
  static String menuRestaurant = '/menuRestaurant';
  static String orderRestaurant = '/orderRestaurant';
  static String profileRestaurant = '/profileRestaurant';
}

class AppPages {
  static final List<GetPage> pages =  [
    //KARYAWAN
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginHeader(),
        binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.main,
        page: () => const MainContainer(),
        bindings: [LoginBinding(), CartBinding(), HomeBinding() ],
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.cart,
        page: () => const CartContainer(),
        // binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeContainer(),
        bindings: [LoginBinding(), HomeBinding()],
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.order,
        page: () => const OrderContainer(),
        binding: OrderBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.profile,
        page: () => const ProfileContainer(),
        binding: OrderBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),

    //RESTAURANT
    GetPage(
        name: AppRoutes.restaurant,
        page: () => const RestaurantMainContainer(),
        binding: RestaurantBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.menuRestaurant,
        page: () => MenuRestaurantContainer(),
        binding: AdminBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.orderRestaurant,
        page: () => OrderRestaurantContainer(),
        binding: AdminBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.profileRestaurant,
        page: () => const ProfileRestaurantContainer(),
        binding: AdminBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    //ADMIN
    GetPage(
        name: AppRoutes.admin,
        page: () => const AdminContainer(),
        binding: AdminBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
  ];
}
