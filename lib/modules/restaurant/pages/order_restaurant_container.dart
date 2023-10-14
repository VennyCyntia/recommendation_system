import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/controller/restaurant_tabs_controller.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/order_done_component.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/order_process_component.dart';

class OrderRestaurantContainer extends StatelessWidget {
  const OrderRestaurantContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: kMinInteractiveDimension,
          left: ThemeConfig().extraSpacing,
          right: ThemeConfig().extraSpacing,
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: ThemeConfig.justBlack)
                ),
                child: TabBar(
                    unselectedLabelColor: ThemeConfig.lightGrey,
                    controller: Get.find<RestaurantTabsController>().controller,
                    tabs: Get.find<RestaurantTabsController>().tabsOrder,
                    indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: Colors.black)),
                    indicatorPadding: const EdgeInsets.all(8.0),
                    dividerColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: ThemeConfig().textHeader5Bold(color: Colors.grey)
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: Get.find<RestaurantTabsController>().controller,
                children: const [
                  OrderProcessComponent(),
                  OrderDoneComponent(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
