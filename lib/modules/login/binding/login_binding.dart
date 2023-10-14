import 'package:get/get.dart';
import 'package:recommendation_system/Modules/Login/Controller/login_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/home_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(LoginController());
  }
}