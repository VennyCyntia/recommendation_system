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
  var selectedDescription= List<String>.empty(growable: true).obs;
  var selectedValue= List<String>.empty(growable: true).obs;
  var lsPic = List<dynamic>.empty(growable: true).obs;

  var editFieldMenu = List<TextEditingController>.empty(growable: true).obs;

  List<DropdownMenuItem<String>> listCategory = [
    const DropdownMenuItem(child: Text("Menu utama"), value: "Menu utama"),
    const DropdownMenuItem(child: Text("Menu pendamping"), value: "Menu pendamping"),
    const DropdownMenuItem(child: Text("Minuman"), value: "Minuman"),
  ];

  var lsDescription = {
    0: [const DropdownMenuItem(child: Text(""), value: ""), const DropdownMenuItem(child: Text("NASI"), value: "NASI"),const DropdownMenuItem(child: Text("MIE"), value: "MIE")],
    1: [const DropdownMenuItem(child: Text(""), value: ""), const DropdownMenuItem(child: Text("PEDAS"), value: "PEDAS"),const DropdownMenuItem(child: Text("MANIS"), value: "MANIS")],
    2: [const DropdownMenuItem(child: Text(""), value: ""), const DropdownMenuItem(child: Text("AYAM"), value: "AYAM"),const DropdownMenuItem(child: Text("SAPI"), value: "SAPI")],
    3: [const DropdownMenuItem(child: Text(""), value: ""), const DropdownMenuItem(child: Text("KUAH"), value: "KUAH"),const DropdownMenuItem(child: Text("KERING"), value: "KERING")],
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
      print('lspic '+lsPic[index].toString());
    } else {
      log('path file not found');
    }
  }

  onAddDesc(int index, String value, int indexLength) {
    // List<String> tempValue = [];
    // tempValue.add(value);
    //
    // if(selectedValue[indexLength].isNotEmpty){
    //   selectedValue[index][indexLength] = value;
    //   // selectedValue[index][indexLength] = selectedValue[index][indexLength] + value;
    // }
    // print('selected '+selectedValue[index][indexLength].toString());

    if (selectedDescription.isNotEmpty && index >= 0 && index < selectedDescription.length && !selectedDescription[index].contains(value)) {
      selectedDescription[index] =
          (selectedDescription[index] ?? '') +
              (selectedDescription[index].isNotEmpty
                  ? ', '
                  : '') +
              (value ?? '');
    }
    print('result '+selectedDescription[index]);
  }

  onInitialAddForm(){
    lsFormMenu.add(List.generate(3, (index) => TextEditingController()));
    lsPic.add('');
    selectedDescription.add('');
    selectedCategory.add('');
  }

  Future<void> onSaveMenu() async {
    if(formKey.currentState!.validate()){
      List<ViewMenu> tempMenu = [];

      for(int i=0; i<lsFormMenu.length; i++){
        tempMenu.add(ViewMenu(
          title: lsFormMenu[i][0].text,
          subtitle: lsFormMenu[i][1].text ,
          category: selectedCategory[i],
          description: selectedDescription[i],
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

    if(menu.id != null){
      editFieldMenu.clear();
      lsPic.clear();
      selectedCategory.clear();
      selectedDescription.clear();

      editFieldMenu.add(TextEditingController(text: menu.title));
      editFieldMenu.add(TextEditingController(text: menu.subtitle));
      editFieldMenu.add(TextEditingController(text: menu.price.toString()));
      lsPic.add(menu.pic);
      selectedCategory.add(menu.category!);
      for(int i=0; i<valuesList.length; i++){
        selectedValue.add(valuesList[i]);
        print(selectedValue[i]);
      }

      Get.to(() => EditMenuComponent(id: id, index: index));
    }


  }

  Future<void> onGetAllData() async {
    var menu = await RestaurantDatabase.instance.selectAllMenu();
    for(var item in menu){
      lsMenu.add(ViewMenu.fromJson(item));
    }
  }

  onClearData(){
    lsFormMenu.clear();
    selectedDescription.clear();
    selectedCategory.clear();
    lsPic.clear();
    onInitialAddForm();
    Get.back();
  }

}