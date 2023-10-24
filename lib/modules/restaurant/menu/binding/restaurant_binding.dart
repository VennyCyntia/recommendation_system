import 'package:get/get.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/main_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/menu_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/tabs_controller.dart';

class RestaurantBinding extends Bindings {
  void dependencies(){
    Get.put(RestaurantMenuController());
    Get.put(TabsController());
    Get.lazyPut(() => RestaurantController());
  }
}