import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/Routes/app_routes.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/order_not_paid_container.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/employee_profile_controller.dart';

class EmployeeOrderController extends GetxController{
  var profileController = Get.put(EmployeeProfileController());
  var lsRating = List<dynamic>.empty(growable: true).obs;
  
  var lsOrder = List<Order>.empty(growable: true).obs;

  var detailOrder = {};

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
      tempOrder = allOrder.where((item) => item.status != 'PENDING' && item.status != 'DONE').toList();
    } else {
      tempOrder = allOrder.where((item) => item.status == 'DONE').toList();
    }

    if(tempOrder.isNotEmpty){
      lsOrder.addAll(tempOrder);
    }

  }

  Future<void> onViewOrder({required String order_id, BuildContext? context, required int index}) async {
    Map body = {
      "TransId": order_id
    };

    String url = GlobalUrl.viewBill;
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', headerType: 'setWallet', wallet_id: lsOrder[index].wallet_id, body: body);

    if(!result.toLowerCase().contains('failed')){
      var data = jsonDecode(result);
      detailOrder = {
        "order_id": data['TransId'],
        "bill_date": data['BillDate'],
        "Expired_date": data['ExpiryDate']
      };

      showDialog(context: context!, builder: (context) => ShowPaymentInformation(index: index));
    }

  }

  Future<void> onPayBill({required String orderId}) async {
    var order = lsOrder.firstWhere((item) => item.order_id == orderId);
    if(int.parse(profileController.balance.text) < order.total_price!.toInt()){
        DialogConfig().onShowDialogInformation(
            title: 'Failed', 
            content: 'Saldo anda tidak mencukupi, silahkan top up terlebih dahulu', 
            color: Colors.red);
    }else {
      Map body = {
        "TransId": orderId
      };

      String url = GlobalUrl.payBill;
      var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', headerType: 'setWallet', wallet_id: profileController.walletId.value, body: body);
      if(!result.toLowerCase().contains('failed')){
        onUpdateStatus(orderId: orderId, status: "WAITING FOOD");
      }else{
        DialogConfig().onShowDialogInformation(title: 'failed', content: 'Bill has expired', color: Colors.red);
      }
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
      await profileController.onGetBalance();
      Get.offNamedUntil(AppRoutes.employeeMain, (route) => route.settings.name == AppRoutes.employeeMain);
    }
  }

  Future<void> deleteOrder({required String orderId}) async {
    String url = GlobalUrl.baseUrl + GlobalUrl.deleteOrder + orderId;
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: {});
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    } else {
      // Get.offNamedUntil(AppRoutes.employeeMain, (route) => route.settings.name == AppRoutes.employeeMain);
      await onGetAllData(value: 0).then((value) => Get.back());
    }
  }

  Future<void> onSaveRating({required String orderId}) async {
    Order? currentOrder = lsOrder.firstWhereOrNull((item) => item.order_id == orderId);
    List<Map<String, dynamic>> tempRatingMenu = [];
    Map<dynamic, dynamic> menu = {};

    if(lsRating.isNotEmpty){
      if(currentOrder != null){
        for(int i=0; i<lsRating.length; i++){
          tempRatingMenu.add({
            'user_id': profileController.id.value,
            'menu_id': currentOrder.menu![i].menu_id,
            'rating': lsRating[i]
          });
        }
        menu['rating'] = tempRatingMenu;
      }
    }else{
      //tambahin snacbar rating gak boleh kosong
    }
    log(jsonEncode(menu));

    String url = GlobalUrl.baseUrl + GlobalUrl.sendRating;
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: menu);
    print('result'+result.toString());
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    } else {
      await onUpdateStatus(orderId: orderId, status: 'DONE');
    }
  }

  onSetRating(int index, int value){
    if(index >= 0 && index < lsRating.length){
      lsRating[index] = value;
    } else {
      lsRating.add(value);
    }

    print('value '+lsRating.toString());
  }
}