import 'package:get/get.dart';
import 'package:recommendation_system/Routes/routes.dart';

class LoginController extends GetxController {
  var currentIndex = 0.obs;

  void selectedItems(int index){
    switch (index){
      case 0:
        currentIndex.value = index;
        break;
      case 1:
        onToOrderContainer();
        break;
      case 2:
        onToCartContainer();
        break;
      case 3:
        onToProfileContainer();
        break;
    }
  }

  void onToOrderContainer(){
    Get.toNamed(AppRoutes.order);
  }

  void onToCartContainer(){
    Get.toNamed(AppRoutes.cart);
  }

  void onToProfileContainer(){
    Get.toNamed(AppRoutes.profile);
  }
}

