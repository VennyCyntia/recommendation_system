import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/employee_order_controller.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/employee_tabs_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies(){
    Get.put(EmployeeTabsController());
    Get.put(EmployeeOrderController());
  }
}