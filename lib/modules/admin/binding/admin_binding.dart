import 'package:get/get.dart';
import 'package:recommendation_system/modules/admin/controller/admin_tabs_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(AdminTabsController());
  }
}