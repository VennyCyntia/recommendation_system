import 'package:get/get.dart';
import 'package:recommendation_system/Modules/Login/Controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(LoginController());
  }
}