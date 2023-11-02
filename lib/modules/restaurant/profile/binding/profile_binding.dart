import 'package:get/get.dart';
import 'package:recommendation_system/modules/restaurant/profile/controller/restaurant_profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(RestaurantProfileController());
  }
}