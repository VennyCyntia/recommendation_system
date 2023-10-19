import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/admin/controller/admin_restaurant_controller.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/text_field_input_component.dart';

class EditTenantComponent extends GetView<AdminRestaurantController> {
  int id;
  int index;
  EditTenantComponent({super.key, required this.id, required this.index});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => controller.onClearData(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Edit Tenant'),
          ),
          body: Padding(
            padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                  margin: EdgeInsets.only(top: ThemeConfig().biggerSpacing),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldInputComponent(
                          txtController: controller.editFieldRestaurant[0],
                          title: 'Nama',
                          keyboardType: TextInputType.text),
                      SizedBox(height: ThemeConfig().defaultSpacing),
                      TextFieldInputComponent(
                          txtController: controller.editFieldRestaurant[1],
                          title: 'Deskripsi',
                          keyboardType: TextInputType.text),
                      SizedBox(width: ThemeConfig().biggerSpacing),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.onUpdateData(id: id, index: index),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: ThemeConfig().defaultSpacing),
                          backgroundColor: Colors.green,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                      child: Text('UPDATE', style: ThemeConfig().textHeader5(color: ThemeConfig.justWhite)),
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
