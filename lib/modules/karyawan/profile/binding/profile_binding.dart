import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies(){
    // Get.lazyPut(() => ProfileController());
    Get.put(ProfileController());
  }
}