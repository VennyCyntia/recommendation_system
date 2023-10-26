import 'package:get/get.dart';

class OrderController extends GetxController{
  var lsRating = List<dynamic>.empty(growable: true).obs;

  @override
  void onInit(){
    super.onInit();
  }

  onGiveRating(int index, int value){
    if(index >= 0 && index < lsRating.length){
      lsRating[index] = value;
    } else {
      lsRating.add(value);
    }
    print('value '+lsRating.value.toString());
  }
}