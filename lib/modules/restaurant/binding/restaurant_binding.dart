import 'package:get/get.dart';
import 'package:recommendation_system/modules/restaurant/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/restaurant/controller/restaurant_tabs_controller.dart';

class RestaurantBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => RestaurantController());
    Get.lazyPut(() => RestaurantTabsController());
  }
}