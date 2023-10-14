import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/tabs_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(TabsController());
  }
}