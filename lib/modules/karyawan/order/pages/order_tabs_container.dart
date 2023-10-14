import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/tabs_controller.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/order_done_container.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/order_not_paid_container.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/order_process_container.dart';


class OrderTabsContainer extends StatelessWidget {
  const OrderTabsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: ThemeConfig.justBlack)
              ),
              child: TabBar(
                  unselectedLabelColor: ThemeConfig.lightGrey,
                  controller: Get.find<TabsController>().controller,
                  tabs: Get.find<TabsController>().tabs,
                  indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: Colors.black)),
                  indicatorPadding: const EdgeInsets.all(8.0),
                  dividerColor: Colors.black,
                  labelColor: Colors.black,
                  labelStyle: ThemeConfig().textHeader5Bold(color: Colors.grey)
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: Get.find<TabsController>().controller,
            children: const [
              OrderNotPaidContainer(),
              OrderProcessContainer(),
              OrderDoneContainer(),
            ],
          ),
        )
      ],
    );
  }
}
