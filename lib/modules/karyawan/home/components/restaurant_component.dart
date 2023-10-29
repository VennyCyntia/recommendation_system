import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/restaurant_page.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class RestaurantComponent extends GetView<RestaurantController> {
  int id;
  int index;

  RestaurantComponent({super.key, required this.id, required this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        GestureDetector(
          onTap: () => controller.onGetRestaurantDetail(id: id, index: index) ,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1.5),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(ThemeConfig().biggerSpacing))),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(ThemeConfig().defaultSpacing)),
                            child:
                            // controller.lsRestaurant[index!]
                            //             .restaurant_image !=
                            //         null
                            //     ? Image.network(controller
                            //         .lsRestaurant[index!].restaurant_image!)
                            //     :
                            Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg')),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              controller
                                  .lsRestaurant[index].restaurant_name!,
                              style: ThemeConfig().textHeader3Bold(
                                  color: ThemeConfig.justBlack)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
