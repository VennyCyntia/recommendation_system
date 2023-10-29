import 'dart:convert';

import 'package:get/get.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/profile_controller.dart';

class OrderController extends GetxController{
  var profileController = Get.put(ProfileController());
  var lsRating = List<dynamic>.empty(growable: true).obs;
  
  var lsOrder = List<Order>.empty(growable: true).obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await onGetAllData(value: 0);
    super.onInit();
  }

  Future<void> onGetAllData({required int value}) async {
    lsOrder.clear();
    List<Order> allOrder = [];
    List<Order> tempOrder = [];

    String url = GlobalUrl.baseUrl + GlobalUrl.getOrderById + profileController.id.value.toString();
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = jsonDecode(result);
    

    for(var item in data){
      allOrder.add(Order.fromJson(item));
    }

    if(value == 0){
      tempOrder = allOrder.where((item) => item.status == 'PENDING').toList();
    } else if (value == 1){
      tempOrder = allOrder.where((item) => item.status == 'SUCCESS').toList();
    } else {
      tempOrder = allOrder.where((item) => item.status == 'DONE').toList();
    }

    if(tempOrder.isNotEmpty){
      lsOrder.addAll(tempOrder);
    }

  }

  onSetRating(int index, int value){
    if(index >= 0 && index < lsRating.length){
      lsRating[index] = value;
    } else {
      lsRating.add(value);
    }
  }
}