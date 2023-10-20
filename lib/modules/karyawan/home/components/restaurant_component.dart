import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/restaurant_page.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class RestaurantComponent extends GetView<RestaurantController> {
  int? index;
  RestaurantComponent({super.key, this.index});

  @override
  Widget build(BuildContext context) {

    return Wrap(
      children: [
        GestureDetector(
          onTap: () => Get.to(() => RestaurantPage(indexRestaurant: index)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400, width: 1.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().biggerSpacing))
                    ),
                    child: Column(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().defaultSpacing)),child: Image.network(controller.lsRestaurantMenu[index!].pic!)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.lsRestaurantMenu[index!].restaurantName!, style: ThemeConfig().textHeader3Bold(color: ThemeConfig.justBlack)),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
