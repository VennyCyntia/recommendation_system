import 'package:get/get.dart';
import 'package:recommendation_system/routes/app_routes.dart';

class RestaurantController extends GetxController{
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
        onToProfileContainer();
        break;
    }
  }

  void onToOrderContainer(){
    Get.toNamed(AppRoutes.orderRestaurant);
  }

  void onToProfileContainer(){
    Get.toNamed(AppRoutes.profileRestaurant);
  }

}