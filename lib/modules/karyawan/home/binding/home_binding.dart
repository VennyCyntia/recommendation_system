import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(RestaurantController());
  }
}