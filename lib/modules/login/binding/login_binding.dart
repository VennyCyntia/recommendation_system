import 'package:get/get.dart';
import 'package:recommendation_system/modules/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => LoginController(), fenix: true);
  }
}