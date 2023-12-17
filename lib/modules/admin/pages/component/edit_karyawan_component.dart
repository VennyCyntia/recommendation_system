import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/admin/controller/admin_employee_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/component/text_field_input_component.dart';

class EditKaryawanComponent extends GetView<AdminEmployeeController> {
  int id;
  EditKaryawanComponent({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit karyawan'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                  margin: EdgeInsets.only(top: ThemeConfig().biggerSpacing),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldInputComponent(
                          title: 'Nama',
                          keyboardType: TextInputType.text,
                          txtController:
                          controller.editFieldEmployee[0]
                      ),
                      SizedBox(height: ThemeConfig().defaultSpacing),
                      TextFieldInputComponent(
                          title: 'Email',
                          keyboardType: TextInputType.text,
                          txtController:
                          controller.editFieldEmployee[1]
                      ),
                      SizedBox(width: ThemeConfig().biggerSpacing),
                      TextFieldInputComponent(
                          title: 'No Telepon',
                          keyboardType: TextInputType.number,
                          txtController:
                          controller.editFieldEmployee[2]
                      ),
                      SizedBox(height: ThemeConfig().biggerSpacing),
                      TextFieldInputComponent(
                          title: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          txtController:
                          controller.editFieldEmployee[3]
                      ),
                      SizedBox(height: ThemeConfig().biggerSpacing),
                      TextFieldInputComponent(
                          title: 'Role',
                          keyboardType: TextInputType.visiblePassword,
                          txtController:
                          controller.editFieldEmployee[4]
                      ),
                      SizedBox(height: ThemeConfig().biggerSpacing),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.onUpdateData(id: id),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: ThemeConfig().defaultSpacing),
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  5.0)))),
                      child: Text('UPDATE', style: ThemeConfig().textHeader5(
                          color: ThemeConfig.justWhite)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
