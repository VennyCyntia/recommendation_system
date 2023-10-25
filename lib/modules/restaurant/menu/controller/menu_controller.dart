import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/config/session_manager.dart';
import 'package:recommendation_system/app/models/attachment_file_data_model.dart';
import 'package:recommendation_system/app/models/view_restaurant.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/component/edit_menu_component.dart';

class RestaurantMenuController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var lsMenu = List<ViewMenu>.empty(growable: true).obs;
  var lsFormMenu = List<List<TextEditingController>>.empty(growable: true).obs;
  var selectedCategory = List<String>.empty(growable: true).obs;
  var selectedDesc = List<List<String>>.empty(growable: true).obs;
  var lsPic = List<dynamic>.empty(growable: true).obs;

  var editLsPic = List<dynamic>.empty(growable: true).obs;
  var editFieldMenu = List<TextEditingController>.empty(growable: true).obs;
  var editSelectedDesc = List<String>.empty(growable: true).obs;

  List<DropdownMenuItem<String>> listCategory = [
    const DropdownMenuItem(child: Text(""), value: ""),
    const DropdownMenuItem(child: Text("Menu utama"), value: "Menu utama"),
    const DropdownMenuItem(
        child: Text("Menu pendamping"), value: "Menu pendamping"),
    const DropdownMenuItem(child: Text("Minuman"), value: "Minuman"),
  ];

  var lsDescription = {
    0: [
      const DropdownMenuItem(child: Text(""), value: ""),
      const DropdownMenuItem(child: Text("NASI"), value: "NASI"),
      const DropdownMenuItem(child: Text("MIE"), value: "MIE")
    ],
    1: [
      const DropdownMenuItem(child: Text(""), value: ""),
      const DropdownMenuItem(child: Text("PEDAS"), value: "PEDAS"),
      const DropdownMenuItem(child: Text("MANIS"), value: "MANIS")
    ],
    2: [
      const DropdownMenuItem(child: Text(""), value: ""),
      const DropdownMenuItem(child: Text("AYAM"), value: "AYAM"),
      const DropdownMenuItem(child: Text("SAPI"), value: "SAPI")
    ],
    3: [
      const DropdownMenuItem(child: Text(""), value: ""),
      const DropdownMenuItem(child: Text("KUAH"), value: "KUAH"),
      const DropdownMenuItem(child: Text("KERING"), value: "KERING")
    ],
  }.obs;

  var id = 0.obs;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController no_telp = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    onInitialAddForm();
    await onGetUserInformation().then((value) => onGetAllData());
    isLoading.value = false;
    super.onInit();
  }

  Future<void> onGetUserInformation() async {
    id.value = await UserSession().onGetId();
    print('id restaurant ' + id.toString());
    username.text = await UserSession().onGetUsername();
    email.text = await UserSession().onGetEmail();
    no_telp.text = await UserSession().onGetNoTelepon();
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
    lsFormMenu.add(List.generate(3, (index) => TextEditingController()));
    lsPic.add('');
    selectedCategory.add('');
    selectedDesc.add(['', '', '', '']);
  }

  Future<void> onSaveMenu() async {
    // DialogConfig().onShowBasicLoading();
    if (formKey.currentState!.validate()) {
      List<ViewMenu> tempMenu = [];
      List<String> combinedDesc = [];

      for (int i = 0; i < selectedDesc.length; i++) {
        for (int j = 0; j < selectedDesc[i].length; j++) {
          if (j == 0) {
            combinedDesc.add(selectedDesc[i][j]);
          } else {
            combinedDesc[i] = '${combinedDesc[i]}, ${selectedDesc[i][j]}';
          }
        }
      }

      for (int i = 0; i < lsFormMenu.length; i++) {
        AttachmentFileDataModel result = await APIConfig().uploadAttachment(filepath: File(lsPic[i]));
        tempMenu.add(ViewMenu(
            menu_name: lsFormMenu[i][0].text,
            menu_subtitle: lsFormMenu[i][1].text,
            menu_category: selectedCategory[i],
            menu_description: combinedDesc[i],
            menu_price: int.parse(lsFormMenu[i][2].text),
            menu_image: result.attachment_id,
            restaurant_id: id.value));
      }

      List<Map<String, dynamic>> menuList =
          tempMenu.map((tempMenu) => tempMenu.toJson()).toList();
      await onSendData(body: menuList);
      await onGetAllData();
      // Get.back();
      onClearData();
    }
  }

  Future<void> onShowEditMenu({required int index, required int id}) async {
    String url = '${GlobalUrl.baseUrl}${GlobalUrl.getMenuById}$id';
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {
    } else {
      var data = json.decode(result);
      List<String> valuesList = data['menu_description'].split(', ');

      editFieldMenu.clear();
      // lsPic.clear();
      editLsPic.clear();
      selectedCategory.clear();
      editSelectedDesc.clear();

      editFieldMenu.add(TextEditingController(text: data['menu_name']));
      editFieldMenu.add(TextEditingController(text: data['menu_subtitle']));
      editFieldMenu
          .add(TextEditingController(text: data['menu_price'].toString()));
      selectedCategory.add(data['menu_category']!);
      for (int i = 0; i < valuesList.length; i++) {
        editSelectedDesc.add(valuesList[i]);
      }

      String getAttachmentUrl = GlobalUrl.baseUrl + GlobalUrl.getAttachment + data['menu_image'];
      var image = await APIConfig().getFile(uploadUrl: getAttachmentUrl);

      editLsPic.add(image);

      Get.to(() => EditMenuComponent(index: index, id: id));
    }
  }

  Future<void> onUpdateData({required int id}) async {
    String combinedDesc = '';

    for (int i = 0; i < editSelectedDesc.length; i++) {
      if (i == 0) {
        combinedDesc = editSelectedDesc[i];
      } else {
        combinedDesc = '$combinedDesc, ${editSelectedDesc[i]}';
      }
    }

    Map tempMenu = {
      'menu_name': editFieldMenu[0].text,
      'menu_subtitle': editFieldMenu[1].text,
      'menu_category': selectedCategory[0],
      'menu_description': combinedDesc,
      'menu_price': int.parse(editFieldMenu[2].text),
      'menu_image': '/data',
    };
    log(jsonEncode(tempMenu));

    String url = GlobalUrl.baseUrl + GlobalUrl.updateMenu + id.toString();
    var result = await APIConfig()
        .onSendOrGetSource(url: url, methodType: 'POST', body: tempMenu);

    await onGetAllData().then((value) =>
        Future.delayed(const Duration(milliseconds: 100), () => Get.back()));
  }

  Future<void> onDeleteData({required int id}) async {
    String url = '${GlobalUrl.baseUrl}${GlobalUrl.deleteMenu}$id';
    var result =
        await APIConfig().sendDataToApi(url: url, method: 'POST', body: []);
    onGetAllData();
  }

  Future<void> onDeleteForm({required int index}) async {
    lsFormMenu.removeAt(index);
    selectedCategory.removeAt(index);
    lsPic.removeAt(index);
    selectedDesc.removeAt(index);
  }

  Future<void> onGetAllData() async {
    lsMenu.clear();

    String url =
        GlobalUrl.baseUrl + GlobalUrl.getMenuByRestaurant + id.toString();
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    if (!result.toLowerCase().contains('failed') &&
        !result.toLowerCase().contains('gagal') &&
        !result.toLowerCase().contains('error') &&
        !result.toLowerCase().contains('false')) {
      List<dynamic> jsonList = json.decode(result);
      for (var item in jsonList) {
        lsMenu.add(ViewMenu.fromJson(item));
      }
    } else {}
  }

  //senddata
  Future<void> onSendData({required List body}) async {
    String result = 'error';
    String url = GlobalUrl.baseUrl + GlobalUrl.createMenu;
    result =
        await APIConfig().sendDataToApi(url: url, body: body, method: 'POST');
    print('result ' + result.toString());
    if (result.toString().contains('success')) {
      print('berhasil ges');
    } else {
      print('gagal, coba lagi yuk');
    }
  }

  onClearData() {
    lsFormMenu.clear();
    selectedDesc.clear();
    selectedCategory.clear();
    lsPic.clear();
    onInitialAddForm();
    Get.back();
  }


}
