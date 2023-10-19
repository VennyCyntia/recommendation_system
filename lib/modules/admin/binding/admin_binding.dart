import 'package:get/get.dart';
import 'package:recommendation_system/modules/admin/controller/admin_employee_controller.dart';
import 'package:recommendation_system/modules/admin/controller/admin_restaurant_controller.dart';
import 'package:recommendation_system/modules/admin/controller/admin_tabs_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(AdminTabsController());
    Get.lazyPut(() => AdminRestaurantController());
    Get.lazyPut(() => AdminEmployeeController());
    // Get.put(AdminRestaurantController());
  }
}