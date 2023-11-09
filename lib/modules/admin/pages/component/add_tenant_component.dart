import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/admin/controller/admin_restaurant_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/component/text_field_input_component.dart';

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
                        itemCount: controller.lsFormRestaurant.length,
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
                                        onPressed: () => controller
                                            .onDeleteForm(index: index),
                                        icon: const Icon(Icons.delete))),
                                TextFieldInputComponent(
                                    title: 'Username',
                                    keyboardType: TextInputType.text,
                                    txtController:
                                        controller.lsFormRestaurant[index][0]),
                                SizedBox(height: ThemeConfig().defaultSpacing),
                                TextFieldInputComponent(
                                    title: 'Nama Restoran',
                                    keyboardType: TextInputType.text,
                                    txtController:
                                        controller.lsFormRestaurant[index][1]),
                                SizedBox(height: ThemeConfig().defaultSpacing),
                                TextFieldInputComponent(
                                    title: 'Email',
                                    keyboardType: TextInputType.text,
                                    txtController:
                                        controller.lsFormRestaurant[index][2]),
                                SizedBox(height: ThemeConfig().defaultSpacing),
                                TextFieldInputComponent(
                                    title: 'No Telepon',
                                    keyboardType: TextInputType.number,
                                    txtController:
                                        controller.lsFormRestaurant[index][3]),
                                SizedBox(height: ThemeConfig().defaultSpacing),
                                TextFieldInputComponent(
                                    title: 'Password',
                                    keyboardType: TextInputType.visiblePassword,
                                    txtController:
                                        controller.lsFormRestaurant[index][4]),
                                SizedBox(height: ThemeConfig().defaultSpacing),
                                TextFieldInputComponent(
                                    title: 'Deskripsi Restoran',
                                    keyboardType: TextInputType.text,
                                    txtController:
                                        controller.lsFormRestaurant[index][5]),
                                SizedBox(height: ThemeConfig().biggerSpacing),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: Container(
                                //           margin: EdgeInsets.only(
                                //               right:
                                //                   ThemeConfig().defaultSpacing),
                                //           decoration: BoxDecoration(
                                //               color: Colors.grey,
                                //               borderRadius: BorderRadius.all(
                                //                   Radius.circular(ThemeConfig()
                                //                       .defaultSpacing))),
                                //           child: Obx(() => SizedBox.fromSize(
                                //               size: const Size.fromRadius(40),
                                //               child: controller.lsPic[index] != ''
                                //                   ? Image.file(File(controller.lsPic[index]),
                                //                       fit: BoxFit.fill)
                                //                   : const Center(
                                //                       child:
                                //                           Text('No photo'))))),
                                //     ),
                                //     Expanded(
                                //       child: ElevatedButton(
                                //         onPressed: () =>
                                //             controller.onGetImage(index: index),
                                //         style: ElevatedButton.styleFrom(
                                //             primary: Colors.blue,
                                //             minimumSize:
                                //                 const Size.fromHeight(48),
                                //             elevation: 0,
                                //             shape: RoundedRectangleBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(
                                //                         ThemeConfig()
                                //                             .defaultSpacing))),
                                //         child: Text('from gallery',
                                //             style: ThemeConfig()
                                //                 .textHeader5Bold(
                                //                     color:
                                //                         ThemeConfig.justWhite)),
                                //       ),
                                //     ),
                                //   ],
                                // ),
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
