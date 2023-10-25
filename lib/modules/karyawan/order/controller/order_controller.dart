import 'package:get/get.dart';

class OrderController extends GetxController{
  var ratingValue = List<dynamic>.empty(growable: true).obs;

  onSendRating(){
    for(var item in ratingValue){
      print('rating '+ratingValue.toString());
    }
  }

  onGiveRating(int index, int value){
    if(ratingValue.length > index && ratingValue[index] != null){
      print('ada');
       ratingValue[index] = value;
    } else {
      ratingValue.add(value);
    }
  }
}