import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_admin.dart';
import 'package:recommendation_system/modules/admin/pages/component/edit_karyawan_component.dart';

class AdminEmployeeController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var lsFormEmployee =
      List<List<TextEditingController>>.empty(growable: true).obs;
  var editFieldEmployee = List<TextEditingController>.empty(growable: true).obs;
  var lsEmployee = List<ViewEmployee>.empty(growable: true).obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await onInitialAddForm();
    await
    onGetAllData();
    isLoading.value = false;
    super.onInit();
  }

  onInitialAddForm() {
    lsFormEmployee.add(List.generate(5, (index) => TextEditingController()));
  }

  Future<void> onSaveEmployee() async {
    String resultWallet = 'error';
    if (formKey.currentState!.validate()) {

      for (int i = 0; i < lsFormEmployee.length; i++) {
        Map<String, dynamic> tempWallet = {
          "Email": lsFormEmployee[i][1].text,
          "DisplayName": lsFormEmployee[i][0].text,
        };

        // String urlCreateWallet = GlobalUrl.registerWallet;
        // resultWallet = await APIConfig().onSendOrGetSource(
        //     url: urlCreateWallet,
        //     body: tempWallet,
        //     methodType: 'POST',
        //     headerType: 'wallet');

        // if (resultWallet.toLowerCase().contains('failed')) {
        //   print('gagal ges');
        // } else if(resultWallet.toLowerCase().contains('registered')){
        //   print('email sudah terdaftar');
        // } else {
        //   var data = jsonDecode(resultWallet);
        //   print('walletid '+data['WalletId']);

          ViewEmployee tempEmployee = ViewEmployee(
            username: lsFormEmployee[i][0].text,
            email: lsFormEmployee[i][1].text,
            no_telp: lsFormEmployee[i][2].text,
            password: lsFormEmployee[i][3].text,
            role: lsFormEmployee[i][4].text,
            wallet_id: "data['WalletId']",
          );

          await onSendData(employee: [tempEmployee]);
          await onGetAllData();
          onClearData();
        // }

      }
    }
  }

  Future<void> onUpdateData({required int id}) async {
    ViewEmployee tempEmployee = ViewEmployee(
      username: editFieldEmployee[0].text,
      email: editFieldEmployee[1].text,
      no_telp: editFieldEmployee[2].text,
      password: editFieldEmployee[3].text,
      role: editFieldEmployee[4].text,
    );

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.updateEmployee}$id';
    var result = await APIConfig()
        .sendDataToApi(url: url, method: 'POST', body: [tempEmployee]);

    await onGetAllData().then((value) =>
        Future.delayed(const Duration(milliseconds: 100), () => Get.back()));
  }

  Future<void> onGetAllData() async {
    lsEmployee.clear();

    String url = GlobalUrl.baseUrl + GlobalUrl.getAllEmployee;
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    if (!result.toLowerCase().contains('failed') &&
        !result.toLowerCase().contains('gagal') &&
        !result.toLowerCase().contains('error') &&
        !result.toLowerCase().contains('false')) {
      List<dynamic> jsonList = json.decode(result);
      for (var item in jsonList) {
        lsEmployee.add(ViewEmployee.fromJson(item));
      }
    } else {}
  }

  Future<void> onShowEditMenu({required int id}) async {
    String url = '${GlobalUrl.baseUrl}${GlobalUrl.getEmployeeById}$id';
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = json.decode(result);

    editFieldEmployee.add(TextEditingController(text: data['username']));
    editFieldEmployee.add(TextEditingController(text: data['email']));
    editFieldEmployee.add(TextEditingController(text: data['no_telp']));
    editFieldEmployee.add(TextEditingController(text: data['password']));
    editFieldEmployee.add(TextEditingController(text: data['role']));

    Get.to(() => EditKaryawanComponent(id: id));
  }

  Future<void> onDeleteData({required int id}) async {
    String url = '${GlobalUrl.baseUrl}${GlobalUrl.deleteEmployee}$id';
    var result =
        await APIConfig().sendDataToApi(url: url, method: 'POST', body: []);
    onGetAllData();
  }

  Future<void> onDeleteForm({required int index}) async {
    lsFormEmployee.removeAt(index);
  }

  onClearData() {
    lsFormEmployee.clear();
    onInitialAddForm();
    Get.back();
  }

  //senddata
  Future<void> onSendData(
      {required List employee}) async {
    String resultEmployee = 'error';

    String urlCreateEmployee = GlobalUrl.baseUrl + GlobalUrl.createEmployee;
    resultEmployee = await APIConfig()
        .sendDataToApi(url: urlCreateEmployee, body: employee, method: 'POST');

    print('result ' + resultEmployee.toString());
    if (resultEmployee.toString().contains('success')) {
      print('berhasil ges');
    } else {
      print('gagal, coba lagi yuk');
    }
  }
}
