import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';


class MenuComponent extends GetView<RestaurantController> {
  int? index;
  String? type;
  MenuComponent({super.key, this.index, this.type});

  @override
  Widget build(BuildContext context) { return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: GestureDetector(
          onTap: () => controller.onToMenuContainer(menu_id: type == 'similar' ? controller.lsSimilarMenu[index!].menu_id :controller
              .recommendationMenu[index!]['menu_id']),
          child: Wrap(
            children: [
              Container(
                height: 175,
                  margin: const EdgeInsets.only(right: 8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      )],
                      border: Border.all(color: Colors.grey.shade400, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ThemeConfig().minSpacing)),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Expanded(
                        child:
                        Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg'),
                        // Image.memory(
                        //   type == 'similar' ? controller.lsSimilarMenu[index!].menu_image :
                        //     controller
                        //         .recommendationMenu[index!]['menu_image'],
                        //     fit: BoxFit.cover),
                      ),
                      Wrap(
                        children: [
                          Text(type == 'similar' ? controller.lsSimilarMenu[index!].menu_name : controller
                              .recommendationMenu[index!]['menu_name']
                          ),
                        ],
                      ),
                      Text(type == 'similar' ? controller.lsSimilarMenu[index!].menu_price.toString() : controller
                          .recommendationMenu[index!]['menu_price'].toString())
                    ],
                  )
              ),
            ],
          ),
        )
    );
  }
}
