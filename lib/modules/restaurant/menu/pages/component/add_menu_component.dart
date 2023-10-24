import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/menu_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/component/text_field_input_component.dart';

class AddMenuComponent extends GetView<RestaurantMenuController> {
  const AddMenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Item'),
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
                  label: Text('Add Item',
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
                    itemCount: controller.lsFormMenu.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                        margin: EdgeInsets.only(top: ThemeConfig().biggerSpacing),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                    onPressed: () => controller.onDeleteForm(index: index),
                                    icon: const Icon(Icons.delete))),
                            TextFieldInputComponent(
                                title: 'Title',
                                keyboardType: TextInputType.text,
                                txtController: controller.lsFormMenu[index][0]),
                            TextFieldInputComponent(
                                title: 'Subtitle',
                                keyboardType: TextInputType.text,
                                txtController: controller.lsFormMenu[index][1]),
                            SizedBox(height: ThemeConfig().defaultSpacing),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 2.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Category',
                                      style: ThemeConfig()
                                          .textHeader4Thin(color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: ThemeConfig()
                                                .textHeader5(color: Colors.red)),
                                      ],
                                    ),
                                  )),
                            ),
                            DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                    ),
                                    contentPadding: EdgeInsets.all(8.0)),
                                value: controller.listCategory[0].value,
                                onChanged: (String? newValue) {
                                  controller.selectedCategory[index] = newValue!;
                                },
                                items: controller.listCategory),
                            SizedBox(height: ThemeConfig().defaultSpacing),
                            FieldDropDown(type: 'add', index: index),
                            SizedBox(height: ThemeConfig().defaultSpacing),
                            TextFieldInputComponent(
                              title: 'Price',
                              keyboardType: TextInputType.number,
                              txtController: controller.lsFormMenu[index][2],
                            ),
                            SizedBox(height: ThemeConfig().biggerSpacing),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          right: ThemeConfig().defaultSpacing),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ThemeConfig().defaultSpacing))),
                                      child: Obx (() => SizedBox.fromSize(
                                          size: const Size.fromRadius(40),
                                          child: controller.lsPic[index] != '' ? Image.file(File(controller.lsPic[index]), fit: BoxFit.fill) : const Center(child: Text('No photo'))))),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => controller.onGetImage(index: index),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue,
                                        minimumSize: const Size.fromHeight(48),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                ThemeConfig().defaultSpacing))),
                                    child: Text('from gallery',
                                        style: ThemeConfig().textHeader5Bold(
                                            color: ThemeConfig.justWhite)),
                                  ),
                                ),
                              ],
                            ),
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
                    onPressed: () => controller.onSaveMenu(),
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