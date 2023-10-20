import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recommendation_system/app/models/view_restaurant.dart';
import 'package:recommendation_system/modules/restaurant/controller/db_restaurant.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/edit_menu_component.dart';

class RestaurantMenuController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var lsMenu = List<ViewMenu>.empty(growable: true).obs;
  var lsFormMenu = List<List<TextEditingController>>.empty(growable: true).obs;
  var selectedCategory = List<String>.empty(growable: true).obs;
  var selectedDesc = List<List<String>>.empty(growable: true).obs;
  var lsPic = List<dynamic>.empty(growable: true).obs;

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

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    onInitialAddForm();
    onGetAllData();
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
    lsFormMenu.add(List.generate(3, (index) => TextEditingController()));
    lsPic.add('');
    selectedCategory.add('');
    selectedDesc.add(['', '', '', '']);
  }

  Future<void> onSaveMenu() async {
    if (formKey.currentState!.validate()) {
      List<ViewMenu> tempMenu = [];
      List<String> combinedDesc = [];

      for (int i = 0; i < selectedDesc.length; i++) {
        for (int j = 0; j < selectedDesc[i].length; j++) {
          if (j == 0) {
            combinedDesc.add(selectedDesc[i][j]);
          } else {
            combinedDesc[i] = combinedDesc[i] + ', ' + selectedDesc[i][j];
          }
        }
      }

      for (int i = 0; i < lsFormMenu.length; i++) {
        tempMenu.add(ViewMenu(
          title: lsFormMenu[i][0].text,
          subtitle: lsFormMenu[i][1].text,
          category: selectedCategory[i],
          description: combinedDesc[i],
          price: int.parse(lsFormMenu[i][2].text),
          pic: lsPic[i],
        ));
      }

      await RestaurantDatabase.instance.insertMenu(tempMenu);
      await onGetAllData();
      onClearData();
    }
  }

  Future<void> onShowEditData({required int index, required int id}) async {
    ViewMenu menu = await RestaurantDatabase.instance.selectMenuByID(id: id);
    List<String> valuesList = menu.description!.split(', ');

    if (menu.id != null) {
      editFieldMenu.clear();
      lsPic.clear();
      selectedCategory.clear();
      editSelectedDesc.clear();

      editFieldMenu.add(TextEditingController(text: menu.title));
      editFieldMenu.add(TextEditingController(text: menu.subtitle));
      editFieldMenu.add(TextEditingController(text: menu.price.toString()));
      lsPic.add(menu.pic);
      selectedCategory.add(menu.category!);
      for(int i=0; i<valuesList.length; i++){
        editSelectedDesc.add(valuesList[i]);
      }

      Get.to(() => EditMenuComponent(id: id, index: index));
    }
  }

  Future<void> onUpdateData({required int id, required int index}) async {
    String combinedDesc = '';

    for (int i = 0; i < editSelectedDesc.length; i++) {
      if (i == 0) {
        combinedDesc = editSelectedDesc[i];
      } else {
        combinedDesc = combinedDesc + ', ' + editSelectedDesc[i];
      }
    }

    ViewMenu tempData = ViewMenu(
        id: id,
        title: editFieldMenu[0].text,
        subtitle: editFieldMenu[1].text,
        category: selectedCategory[0],
        description: combinedDesc,
        price: int.parse(editFieldMenu[2].text),
        pic: lsPic[0]
    );

    await RestaurantDatabase.instance.updateMenuByID(menu: tempData);
    await onGetAllData().then((value) =>
        Future.delayed(const Duration(milliseconds: 100), () => Get.back()));
  }

  Future<void> onDeleteData({required int id}) async {
    await RestaurantDatabase.instance.deleteMenuByID(id: id);
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
    var menu = await RestaurantDatabase.instance.selectAllMenu();
    for (var item in menu) {
      lsMenu.add(ViewMenu.fromJson(item));
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