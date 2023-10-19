import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/models/view_admin.dart';
import 'package:recommendation_system/modules/admin/controller/db_restaurant.dart';
import 'package:recommendation_system/modules/admin/pages/component/edit_tenant_component.dart';

class AdminRestaurantController extends GetxController {
  var formKey = GlobalKey<FormState>();

  var lsFormRestaurant =
      List<List<TextEditingController>>.empty(growable: true).obs;

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

  onInitialAddForm() {
    lsFormRestaurant.add(List.generate(2, (index) => TextEditingController()));
  }

  Future<void> onSaveRestaurant() async {
    if (formKey.currentState!.validate()) {
      List<ViewRestaurant> tempRestaurant = [];

      for (int i = 0; i < lsFormRestaurant.length; i++) {
        tempRestaurant.add(ViewRestaurant(
            restaurantname: lsFormRestaurant[i][0].text,
            description: lsFormRestaurant[i][1].text));
      }

      await RestaurantDatabase.instance.insertRestaurant(tempRestaurant);
      await onGetAllData();
      onClearData();
    }
  }

  Future<void> onShowEditData({required int index, required int id}) async {
    ViewRestaurant restaurant =
    await RestaurantDatabase.instance.selectRestaurantByID(id: id);

    editFieldRestaurant.clear();
    editFieldRestaurant.add(TextEditingController(text: restaurant.restaurantname));
    editFieldRestaurant.add(TextEditingController(text: restaurant.description));

    Get.to(() => EditTenantComponent(id: id, index: index));
  }

  Future<void> onUpdateData({required int id, required int index}) async {
    var restaurantName = editFieldRestaurant[0].text;
    var restaurantDescription = editFieldRestaurant[1].text;
    await RestaurantDatabase.instance.updateRestaurantByID(
        id: id,
        restaurantname: restaurantName,
        restaurantdescription: restaurantDescription);

    await onGetAllData().then((value) =>
        Future.delayed(const Duration(milliseconds: 100), () => Get.back()));
  }

  Future<void> onDeleteData({required int id}) async {
    await RestaurantDatabase.instance.deleteRestaurantByID(id: id);
    onGetAllData();
  }

  Future<void> onDeleteForm({required int index}) async {
    lsFormRestaurant.removeAt(index);
  }

  Future<void> onGetAllData() async {
    lsRestaurant.clear();
    var restaurant = await RestaurantDatabase.instance.selectAllRestaurant();
    for (var item in restaurant) {
      lsRestaurant.add(ViewRestaurant.fromJson(item));
    }
  }

  onClearData() {
    lsFormRestaurant.clear();
    onInitialAddForm();
    Get.back();
  }
}