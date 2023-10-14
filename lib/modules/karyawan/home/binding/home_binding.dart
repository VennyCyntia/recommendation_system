import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/home_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => HomeController());
    // Get.put(RestaurantController());
    Get.lazyPut(() => RestaurantController());
    Get.lazyPut(() => CartController());
  }
}