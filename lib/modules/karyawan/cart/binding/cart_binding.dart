import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies(){
    Get.lazyPut(() => CartController(), fenix: true);
  }
}