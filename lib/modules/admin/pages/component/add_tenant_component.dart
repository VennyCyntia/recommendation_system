import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/admin/controller/admin_restaurant_controller.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/text_field_input_component.dart';

class AddTenantComponent extends GetView<AdminRestaurantController> {
  const AddTenantComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Tenant'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  onPressed: () => controller.onInitialAddForm(),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: ThemeConfig().defaultSpacing),
                      backgroundColor: ThemeConfig.justGrey,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5.0)))),
                  label: Text('Add Tenant',
                      style: ThemeConfig()
                          .textHeader5(color: ThemeConfig.justBlack)),
                  icon: const Icon(Icons.add,
                      color: ThemeConfig.justBlack, size: 20),
                ),
              ),
              Expanded(
                child: Form(
                  key: controller.formKey,
                  child: Obx(() => ListView.builder(
                    padding: EdgeInsets.symmetric(
                        vertical: ThemeConfig().defaultSpacing),
                    itemCount: controller.lsFormRestaurant.value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                        EdgeInsets.all(ThemeConfig().biggerSpacing),
                        margin: EdgeInsets.only(
                            top: ThemeConfig().biggerSpacing),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () => controller.onDeleteForm(index: index),
                                    icon: Icon(Icons.delete))),
                            TextFieldInputComponent(
                                title: 'Nama',
                                keyboardType: TextInputType.text,
                                txtController:
                                controller.lsFormRestaurant[index][0]),
                            SizedBox(height: ThemeConfig().defaultSpacing),
                            TextFieldInputComponent(
                                title: 'Deskripsi',
                                keyboardType: TextInputType.text,
                                txtController:
                                controller.lsFormRestaurant[index][1]),
                            SizedBox(width: ThemeConfig().biggerSpacing),
                          ],
                        ),
                      );
                    },
                  )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => controller.onSaveRestaurant(),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: ThemeConfig().defaultSpacing),
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0)))),
                    child: Text('SAVE',
                        style: ThemeConfig()
                            .textHeader5(color: ThemeConfig.justWhite)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
