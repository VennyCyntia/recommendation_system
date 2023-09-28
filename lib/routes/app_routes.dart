import 'package:get/get.dart';
import 'package:recommendation_system/Modules/Cart/Pages/cart_container.dart';
import 'package:recommendation_system/Modules/Home/Pages/home_container.dart';
import 'package:recommendation_system/Modules/Login/Binding/login_binding.dart';
import 'package:recommendation_system/Modules/Order/Pages/order_container.dart';
import 'package:recommendation_system/modules/home/pages/main_container.dart';
import 'package:recommendation_system/modules/login/pages/login_header.dart';
import 'package:recommendation_system/modules/order/binding/order_binding.dart';

class AppRoutes{
  static String main = '/main';
  static String login = '/login';
  static String home = '/home';
  static String cart = '/cart';
  static String profile = '/profile';
  static String order = '/order';
}

class AppPages {
  static final List<GetPage> pages =  [
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginHeader(),
        // binding: ConfigB(),
        transition: Transition.native,
        transitionDuration: const Duration(milliseconds: 500)
    ),
    GetPage(
        name: AppRoutes.main,
        page: () => const MainContainer(),
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
        binding: OrderBinding(),
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
