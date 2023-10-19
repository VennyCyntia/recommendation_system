import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/models/view_admin.dart';
import 'package:recommendation_system/modules/admin/controller/db_restaurant.dart';
import 'package:recommendation_system/modules/admin/pages/component/edit_karyawan_component.dart';

class AdminEmployeeController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var lsFormEmployee = List<List<TextEditingController>>.empty(growable: true).obs;
  var editFieldEmployee =
      List<TextEditingController>.empty(growable: true).obs;
  var lsEmployee = List<ViewEmployee>.empty(growable: true).obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await onInitialAddForm();
    await onGetAllData();
    isLoading.value = false;
    super.onInit();
  }

  onInitialAddForm(){
    lsFormEmployee.add(List.generate(5, (index) => TextEditingController()));
  }

  Future<void> onSaveEmployee() async {
    if(formKey.currentState!.validate()){
      List<ViewEmployee> tempEmployee = [];

      for(int i=0; i<lsFormEmployee.length; i++){
        tempEmployee.add(ViewEmployee(
          employeename: lsFormEmployee[i][0].text,
          email: lsFormEmployee[i][1].text,
          notelepon: lsFormEmployee[i][2].text,
          password: lsFormEmployee[i][3].text,
          role: lsFormEmployee[i][4].text,
        ));
      }

      await RestaurantDatabase.instance.insertEmployee(tempEmployee);
      await onGetAllData();
      onClearData();
    }
  }

  Future<void> onShowEditMenu({required int index, required int id}) async {
    ViewEmployee employee = await RestaurantDatabase.instance.selectEmployeeByID(id: id);

    editFieldEmployee.clear();
    editFieldEmployee.add(TextEditingController(text: employee.employeename));
    editFieldEmployee.add(TextEditingController(text: employee.email));
    editFieldEmployee.add(TextEditingController(text: employee.notelepon));
    editFieldEmployee.add(TextEditingController(text: employee.password));
    editFieldEmployee.add(TextEditingController(text: employee.role));

    Get.to(() => EditKaryawanComponent(id: id, index: index));
  }

  Future<void> onUpdateData({required int id, required int index}) async {
    var employeename = editFieldEmployee[0].text;
    var email = editFieldEmployee[1].text;
    var notelepon = editFieldEmployee[2].text;
    var password = editFieldEmployee[3].text;
    var role = editFieldEmployee[4].text;
    int result = await RestaurantDatabase.instance.updateEmployeeByID(
        id: id,
        employeename: employeename,
        email: email,
        notelepon: notelepon,
        password: password,
        role: role,
    );

    await onGetAllData().then((value) =>
        Future.delayed(const Duration(milliseconds: 100), () => Get.back()));
  }

  Future<void> onGetAllData() async {
    lsEmployee.clear();
    var employee = await RestaurantDatabase.instance.selectAllEmployee();
    for (var item in employee) {
      lsEmployee.add(ViewEmployee.fromJson(item));
    }
  }

  Future<void> onDeleteData({required int id}) async {
    await RestaurantDatabase.instance.deleteRestaurantByID(id: id);
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
}