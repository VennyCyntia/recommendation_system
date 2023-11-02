import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/employee_profile_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => CartController(), fenix: true);
    Get.put(EmployeeProfileController());
  }
}