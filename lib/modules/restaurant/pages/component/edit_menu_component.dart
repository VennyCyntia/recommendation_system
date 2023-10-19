import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/controller/restaurant_menu_controller.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/text_field_input_component.dart';

class EditMenuComponent extends GetView<RestaurantMenuController> {
  int id;
  int index;
  EditMenuComponent({super.key, required this.id, required this.index});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onClearData(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Menu'),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
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
                                onPressed: () {},
                                icon: const Icon(Icons.delete))),
                        TextFieldInputComponent(
                            title: 'Title',
                            keyboardType: TextInputType.text,
                            txtController: controller.editFieldMenu[0]),
                        TextFieldInputComponent(
                            title: 'Subtitle',
                            keyboardType: TextInputType.text,
                            txtController: controller.editFieldMenu[1]),
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
                            value: controller.selectedCategory[0],
                            onChanged: (String? newValue) {
                              controller.selectedCategory[0] = newValue!;
                            },
                            items: controller.listCategory),
                        SizedBox(height: ThemeConfig().defaultSpacing),
                        EditFieldDropDown(type: 'edit' ,index: index),
                        SizedBox(height: ThemeConfig().defaultSpacing),
                        TextFieldInputComponent(
                          title: 'Price',
                          keyboardType: TextInputType.number,
                          txtController: controller.editFieldMenu[2],
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
                                      child: Image.file(File(controller.lsPic[0]), fit: BoxFit.fill)))),
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: ThemeConfig().defaultSpacing),
                            backgroundColor: Colors.green,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                        child: Text('UPDATE',
                            style: ThemeConfig()
                                .textHeader5(color: ThemeConfig.justWhite)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditFieldDropDown extends GetView<RestaurantMenuController> {
  int? index;
  String type;

  EditFieldDropDown({super.key, this.index, required this.type});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: ThemeConfig().defaultSpacing,
            mainAxisSpacing: 1.0,
            childAspectRatio: 2.5 / 1),
        itemCount: 4,
        itemBuilder: (context, indexLength) {
          return Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Deskripsi ' + indexLength.toString(),
                      style: ThemeConfig().textHeader4Thin(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style:
                            ThemeConfig().textHeader5(color: Colors.red)),
                      ],
                    ),
                  )),
              Expanded(
                child: DropdownButtonFormField<String>(
                    validator: (String? value) {
                      if (value == '') {
                        return 'Mohon mengisi semua kolom dengan benar';
                      }
                      return null;
                    },
                    padding: EdgeInsets.symmetric(
                        vertical: ThemeConfig().defaultSpacing),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: ThemeConfig().defaultSpacing)),
                    value: controller.selectedValue[indexLength],
                    onChanged: (String? newValue) {
                      // String value = newValue!;
                      // controller.onAddDesc(index!, newValue!, indexLength);
                    },
                    items: controller.lsDescription[indexLength]),
              ),
            ],
          );
        });
  }
}
