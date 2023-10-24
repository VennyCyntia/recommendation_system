import 'package:get/get.dart';
import 'package:recommendation_system/modules/admin/binding/admin_binding.dart';
import 'package:recommendation_system/modules/admin/pages/admin_container.dart';
import 'package:recommendation_system/modules/karyawan/cart/binding/cart_binding.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_container.dart';
import 'package:recommendation_system/modules/karyawan/home/binding/home_binding.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/home_container.dart';
import 'package:recommendation_system/modules/karyawan/main_container.dart';
import 'package:recommendation_system/modules/karyawan/order/binding/order_binding.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/order_container.dart';
import 'package:recommendation_system/modules/karyawan/profile/binding/profile_binding.dart' as profileEmployee;
import 'package:recommendation_system/modules/karyawan/profile/pages/profile_container.dart';
import 'package:recommendation_system/modules/login/binding/login_binding.dart';
import 'package:recommendation_system/modules/login/pages/login_body.dart';
import 'package:recommendation_system/modules/restaurant/menu/binding/restaurant_binding.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/menu_restaurant_container.dart';
import 'package:recommendation_system/modules/restaurant/order/pages/order_restaurant_container.dart';
import 'package:recommendation_system/modules/restaurant/profile/binding/profile_binding.dart'  as profileRestaurant;
import 'package:recommendation_system/modules/restaurant/profile/pages/profile_restaurant_container.dart';
import 'package:recommendation_system/modules/restaurant/restaurant_main_container.dart';

class AppRoutes{
  static String employeeMain = '/employeeMain';
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
        page: () => const LoginBody(),
        binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.employeeMain,
        page: () => const MainContainer(),
        bindings: [LoginBinding(), CartBinding(), HomeBinding(), profileEmployee.ProfileBinding()],
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
        bindings: [LoginBinding(), HomeBinding(), profileEmployee.ProfileBinding()],
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
        bindings: [RestaurantBinding(), profileRestaurant.ProfileBinding()],
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.menuRestaurant,
        page: () => const MenuRestaurantContainer(),
        bindings: [AdminBinding(), RestaurantBinding() ],
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.orderRestaurant,
        page: () => const OrderRestaurantContainer(),
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
