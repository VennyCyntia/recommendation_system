import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/employee_profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(EmployeeProfileController());
  }
}