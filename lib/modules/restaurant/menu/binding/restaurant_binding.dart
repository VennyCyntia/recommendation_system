import 'package:get/get.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/main_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/menu_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/restaurant_tabs_controller.dart';

class RestaurantBinding extends Bindings {
  void dependencies(){
    Get.put(RestaurantMenuController());
    Get.put(RestaurantTabsController());
    Get.lazyPut(() => RestaurantController());
  }
}