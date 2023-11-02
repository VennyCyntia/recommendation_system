import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/order/controller/restaurant_order_controller.dart';

class OrderDoneComponent extends GetView<RestaurantOrderController> {
  const OrderDoneComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: controller.lsRestaurantOrder.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only( right: ThemeConfig().defaultSpacing),
                constraints: BoxConstraints(
                    maxHeight: Get.size.height * .125,
                    maxWidth: Get.size.width * .25
                ),
                decoration: const BoxDecoration(
                  color: ThemeConfig.justGrey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.lsRestaurantOrder[index].username!,
                    style: ThemeConfig().textHeader3ExtraBold(
                        color: ThemeConfig.justBlack
                    ),
                  ),
                  SizedBox(height: ThemeConfig().biggerSpacing),
                  Text(
                    controller.lsRestaurantOrder[index].queue_number.toString(),
                    style: ThemeConfig().textHeader2Bold(
                        color: ThemeConfig.justBlack
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}
