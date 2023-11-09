import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/restaurant/profile/controller/restaurant_profile_controller.dart';

class RestaurantOrderController extends GetxController {
  var profileController = Get.put(RestaurantProfileController());
  var lsRestaurantOrder = List<RestaurantOrder>.empty(growable: true).obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await Future.delayed(Duration(milliseconds: 1), () {
      onGetAllData(value: 0); // Panggil onGetAllData setelah fase pembangunan selesai
    });
    super.onInit();
  }

  Future<void> onGetAllData({required int value}) async {
    lsRestaurantOrder.clear();
    List<RestaurantOrder> allOrder = [];
    List<RestaurantOrder> tempOrder = [];

    String url = GlobalUrl.baseUrl + GlobalUrl.getOrderByRestaurant + profileController.id.value.toString();
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = jsonDecode(result);

    for(var item in data){
      allOrder.add(RestaurantOrder.fromJson(item));
    }

    if(value == 0){
      tempOrder = allOrder.where((item) => item.status != 'DONE' && item.status != "PENDING").toList();
    }else {
      tempOrder = allOrder.where((item) => item.status == 'DONE').toList();
    }

    if(tempOrder.isNotEmpty){
      lsRestaurantOrder.addAll(tempOrder);
    }

  }

  Future<void> onUpdateStatus({required String orderId, required String status}) async {
    Map body = {
      "status": status,
      "order_id": orderId
    };
    log(json.encode(body));

    String url = GlobalUrl.baseUrl + GlobalUrl.updateOrder;
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: body);
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    } else {
      Get.back();
      Get.back();
    }
  }

}