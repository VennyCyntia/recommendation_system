import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/employee_profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(RestaurantController());
    Get.put(EmployeeProfileController());
  }
}