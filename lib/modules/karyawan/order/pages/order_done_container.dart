import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/employee_order_controller.dart';

class OrderDoneContainer extends GetView<EmployeeOrderController> {
  const OrderDoneContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: controller.lsOrder.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(
                top: ThemeConfig().minSpacing,
                right: ThemeConfig().extraSpacing,
                bottom: ThemeConfig().extraSpacing),
            child: ListTile(
              leading: Container(
                constraints: BoxConstraints(
                    minHeight: Get.size.height * .25,
                    maxWidth: Get.size.width * .2
                ),
                decoration: const BoxDecoration(
                  color: ThemeConfig.justGrey,
                ),
              ),
              title: Text(
                controller.lsOrder[index].restaurant_name!,
                style: ThemeConfig().textHeader3ExtraBold(
                    color: ThemeConfig.justBlack
                ),
              ),
              subtitle: Text(
                controller.lsOrder[index].queue_number.toString(),
                style: ThemeConfig().textHeader2Bold(
                    color: ThemeConfig.justBlack
                ),
              ),
            )
        );
      },
    ));
  }
}
