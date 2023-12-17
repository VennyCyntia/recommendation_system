import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/menu_controller.dart';

class PreferencePage extends GetView<RestaurantController> {
  const PreferencePage({super.key});

  @override
  Widget build(BuildContext context) {
    var restaurantMenuController = Get.find<RestaurantMenuController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Preference'
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: ThemeConfig().defaultSpacing,
                mainAxisSpacing: 1.0,
                childAspectRatio: 2.5 / 1),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        text: TextSpan(
                          text: 'Deskripsi ',
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
                        value: restaurantMenuController.lsDesc[index]![0].value,
                        onChanged: (String? newValue) {
                          controller.userPreference[index] = newValue!;
                        },
                        items: restaurantMenuController.lsDesc[index]),
                  ),
                ],
              );
            }),
            ElevatedButton(
              onPressed: () => controller.onSaveUserPreference(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(ThemeConfig().defaultSpacing))),
                primary: ThemeConfig.justWhite,
                backgroundColor: ThemeConfig.justGrey,
              ),
              child: Text('SEND',
                  style: ThemeConfig()
                      .textHeader5Bold(color: ThemeConfig.justBlack)),
            ),
          ],
        ),
      ),
    );
  }
}
