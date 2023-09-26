import 'package:get/get.dart';
import 'package:recommendation_system/Modules/Cart/Pages/cart_container.dart';
import 'package:recommendation_system/Modules/Home/Pages/home_container.dart';
import 'package:recommendation_system/Modules/Login/Binding/login_binding.dart';
import 'package:recommendation_system/Modules/Login/Pages/login_container.dart';
import 'package:recommendation_system/Modules/Order/Pages/order_container.dart';

class AppRoutes{
  static String login = '/login';
  static String home = '/home';
  static String cart = '/cart';
  static String profile = '/profile';
  static String order = '/order';
}


class AppPages {
  static final pages =  [
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginContainer(),
        binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.cart,
        page: () => const CartContainer(),
        binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeContainer(),
        binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.order,
        page: () => const OrderContainer(),
        binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.profile,
        page: () => const OrderContainer(),
        binding: LoginBinding(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    )
  ];
}
