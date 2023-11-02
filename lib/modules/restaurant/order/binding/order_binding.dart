import 'package:get/get.dart';
import 'package:recommendation_system/modules/restaurant/order/controller/restaurant_order_controller.dart';

class OrderBinding extends Bindings {
  void dependencies(){
    Get.put(RestaurantOrderController());
  }
}