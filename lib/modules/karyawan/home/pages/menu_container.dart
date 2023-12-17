import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/components/menu_component.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class MenuContainer extends GetView<RestaurantController> {
  const MenuContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Obx(() => SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Image.network(
                          'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
                          fit: BoxFit.fitWidth,
                          width: Get.size.width),
                      // Image.memory(
                      //         controller.menuDetail['menu_image'],
                      //         width: double.maxFinite,
                      //         fit: BoxFit.fitWidth),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ThemeConfig().defaultSpacing,
                            horizontal: ThemeConfig().biggerSpacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.menuDetail['menu_name'] != null ? controller.menuDetail['menu_name'] : '',
                                    style: ThemeConfig().textHeader4Bold(
                                        color: ThemeConfig.justBlack)),
                                Text(
                                    controller.menuDetail['menu_price']
                                        .toString() != null ? controller.menuDetail['menu_price']
                                        .toString() : '',
                                    style: ThemeConfig().textHeader4Bold(
                                        color: ThemeConfig.justBlack))
                              ],
                            ),
                            SizedBox(height: ThemeConfig().extraSpacing),
                            Text(
                                textAlign: TextAlign.justify,
                                controller.menuDetail['menu_subtitle']
                                    .toString()),
                            Obx(() => Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.onDecreaseItem();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey)),
                                        child: const Icon(Icons.remove,
                                            color: ThemeConfig.baseGrey),
                                      ),
                                    ),
                                    SizedBox(width: ThemeConfig().extraSpacing),
                                    Text(
                                        controller.menuDetail['menu_qty']
                                            .toString(),
                                        style: ThemeConfig()
                                            .textHeader1ExtraBold(
                                                color: ThemeConfig.justBlack)),
                                    SizedBox(width: ThemeConfig().extraSpacing),
                                    GestureDetector(
                                      onTap: () {
                                        controller.onIncreaseItem();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ThemeConfig.baseGrey),
                                            shape: BoxShape.rectangle,
                                            color: ThemeConfig.baseGrey),
                                        child: const Icon(Icons.add,
                                            color: ThemeConfig.justBlack),
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(height: ThemeConfig().extraSpacing),
                            Text('Similar Items',
                                style: ThemeConfig().textHeader3Bold(
                                    color: ThemeConfig.justBlack)),
                            SizedBox(height: ThemeConfig().extraSpacing),
                            SizedBox(
                              height: Get.size.height * .22,
                              child: Obx(() => ListView.builder(
                                    reverse: false,
                                    primary: false,
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: controller.lsSimilarMenu.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return MenuComponent(
                                          index: index, type: 'similar');
                                    },
                                  )),
                            ),
                            Obx(() => GestureDetector(
                                  onTap: () {
                                    controller.menuDetail['menu_qty'] == 0
                                        ? null
                                        : controller.onAddMenu(
                                            menuId: controller
                                                .menuDetail['menu_id']);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(
                                          ThemeConfig().biggerSpacing),
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              ThemeConfig().biggerSpacing),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: controller
                                                      .menuDetail['menu_qty'] ==
                                                  0
                                              ? ThemeConfig.baseGrey
                                              : ThemeConfig.justBlack,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: Center(
                                          child: Text('Add to cart',
                                              style: ThemeConfig().textHeader4(
                                                  color:
                                                      ThemeConfig.justWhite)))),
                                ))
                          ],
                        ),
                      ),
                    ],
                  )))),
    );
  }
}
