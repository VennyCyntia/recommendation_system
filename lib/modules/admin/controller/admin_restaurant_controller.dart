import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_admin.dart';
import 'package:recommendation_system/modules/admin/controller/db_restaurant.dart';
import 'package:recommendation_system/modules/admin/pages/component/edit_tenant_component.dart';
import 'package:recommendation_system/modules/admin/pages/component/edit_karyawan_component.dart';

class AdminRestaurantController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var lsFormRestaurant =
      List<List<TextEditingController>>.empty(growable: true).obs;
  var lsPic = List<dynamic>.empty(growable: true).obs;

  var editFieldRestaurant =
      List<TextEditingController>.empty(growable: true).obs;

  var lsRestaurant = List<ViewRestaurant>.empty(growable: true).obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await onInitialAddForm();
    await onGetAllData();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> onGetImage({required int index}) async {
    final ImagePicker imgPicker = ImagePicker();
    XFile? pickedImage;

    pickedImage = await imgPicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
        preferredCameraDevice: CameraDevice.rear);
    if (pickedImage != null) {
      lsPic.value[index] = pickedImage.path;
      lsPic.refresh();
    } else {
      log('path file not found');
    }
  }

  onInitialAddForm() {
    lsFormRestaurant.add(List.generate(6, (index) => TextEditingController()));
    lsPic.add('');
  }

  Future<void> onSaveRestaurant() async {
    if(formKey.currentState!.validate()){
      List<ViewRestaurant> tempRestaurant = [];

      for(int i=0; i<lsFormRestaurant.length; i++){
        tempRestaurant.add(ViewRestaurant(
          username: lsFormRestaurant[i][0].text,
          restaurant_name: lsFormRestaurant[i][1].text,
          email: lsFormRestaurant[i][2].text,
          no_telp: lsFormRestaurant[i][3].text,
          password: lsFormRestaurant[i][4].text,
          restaurant_description: lsFormRestaurant[i][5].text,
          restaurant_image: lsPic[i],
        ));
      }

      List<Map<String, dynamic>> restaurantList = tempRestaurant.map((tempRestaurant) => tempRestaurant.toJson()).toList();
      await onSendData(body: restaurantList);
      await onGetAllData();
      onClearData();
    }
  }

  Future<void> onShowEditRestaurant({required int id}) async {
    String url = '${GlobalUrl.baseUrl}${GlobalUrl.getRestaurantById}$id';
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = json.decode(result);

    editFieldRestaurant.add(TextEditingController(text: data['username']));
    editFieldRestaurant.add(TextEditingController(text: data['restaurant_username']));
    editFieldRestaurant.add(TextEditingController(text: data['email']));
    editFieldRestaurant.add(TextEditingController(text: data['no_telp']));
    editFieldRestaurant.add(TextEditingController(text: data['password']));
    editFieldRestaurant.add(TextEditingController(text: data['restaurant_description']));
    lsPic.add(File(data['restaurant_image']));

    Get.to(() => EditKaryawanComponent(id: id));
  }

  Future<void> onUpdateData({required int id}) async {
    ViewRestaurant tempRestaurant = ViewRestaurant(
      username: editFieldRestaurant[0].text,
      restaurant_name: editFieldRestaurant[1].text,
      email: editFieldRestaurant[2].text,
      no_telp: editFieldRestaurant[3].text,
      password: editFieldRestaurant[4].text,
      restaurant_description: editFieldRestaurant[5].text,
      restaurant_image: lsPic[0].text,
    );

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.updateRestaurant}$id';
    var result = await APIConfig().sendDataToApi(url: url, method: 'POST', body: [tempRestaurant]);

    await onGetAllData().then((value) =>
        Future.delayed(const Duration(milliseconds: 100), () => Get.back()));
  }

  Future<void> onDeleteData({required int id}) async {
    String url = '${GlobalUrl.baseUrl}${GlobalUrl.deleteRestaurant}$id';
    var result = await APIConfig().sendDataToApi(url: url, method: 'POST', body: []);
    onGetAllData();
  }

  Future<void> onDeleteForm({required int index}) async {
    lsFormRestaurant.removeAt(index);
  }

  Future<void> onGetAllData() async {
    lsRestaurant.clear();

    String url = GlobalUrl.baseUrl + GlobalUrl.getAllRestaurant;
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    if (!result.toLowerCase().contains('failed') &&
        !result.toLowerCase().contains('gagal') &&
        !result.toLowerCase().contains('error') &&
        !result.toLowerCase().contains('false')) {
      List<dynamic> jsonList = json.decode(result);
      for (var item in jsonList) {
        lsRestaurant.add(ViewRestaurant.fromJson(item));
      }
    } else {

    }

  }

  // senddata
  Future<void> onSendData({required List body}) async {
    String result = 'error';
    String url = GlobalUrl.baseUrl + GlobalUrl.createRestaurant;
    result = await APIConfig().sendDataToApi(url: url, body: body, method: 'POST');
    print('result '+result.toString());
    if(result.toString().contains('success')){
      print('berhasil ges');
    }else{
      print('gagal, coba lagi yuk');
    }
  }

  onClearData() {
    lsFormRestaurant.clear();
    onInitialAddForm();
    Get.back();
  }
}