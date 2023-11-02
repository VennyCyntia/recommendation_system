import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/home/components/menu_component.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class MenuContainer extends GetView<RestaurantController> {
  int indexCategory;
  int indexitem;

  MenuContainer(
      {super.key,
      required this.indexitem,
      required this.indexCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          // detail.menu![indexCategory].item_menu![index].menu_image != null
          //     ? Image.network(
          //         detail.menu![indexCategory].item_menu![index].menu_image!,
          //         width: double.maxFinite,
          //         fit: BoxFit.fitWidth)
          //     :
          Image.network(
              'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg'),
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
                    Text(
                        controller.restaurantDetail.value.menu![indexCategory]
                            .item_menu![indexitem].menu_name!,
                        style: ThemeConfig()
                            .textHeader4Bold(color: ThemeConfig.justBlack)),
                    Text(
                        controller.restaurantDetail.value.menu![indexCategory]
                            .item_menu![indexitem].menu_price!
                            .toString(),
                        style: ThemeConfig()
                            .textHeader4Bold(color: ThemeConfig.justBlack))
                  ],
                ),
                SizedBox(height: ThemeConfig().extraSpacing),
                Text(
                    textAlign: TextAlign.justify,
                    controller.restaurantDetail.value.menu![indexCategory]
                        .item_menu![indexitem].menu_subtitle!),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => controller.onDecreaseItem(
                              indexItem: indexitem,
                              indexCategory: indexCategory),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child:
                                const Icon(Icons.remove, color: ThemeConfig.baseGrey),
                          ),
                        ),
                        SizedBox(width: ThemeConfig().extraSpacing),
                        Text(
                            controller
                                .restaurantDetail
                                .value
                                .menu![indexCategory]
                                .item_menu![indexitem]
                                .menu_qty!
                                .toString(),
                            style: ThemeConfig().textHeader1ExtraBold(
                                color: ThemeConfig.justBlack)),
                        SizedBox(width: ThemeConfig().extraSpacing),
                        GestureDetector(
                          onTap: () => controller.onIncreaseItem(
                              indexItem: indexitem,
                              indexCategory: indexCategory),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: ThemeConfig.baseGrey),
                                shape: BoxShape.rectangle,
                                color: ThemeConfig.baseGrey),
                            child:
                                const Icon(Icons.add, color: ThemeConfig.justBlack),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: ThemeConfig().extraSpacing),
                Text('Similar Items',
                    style: ThemeConfig()
                        .textHeader3Bold(color: ThemeConfig.justBlack)),
                SizedBox(height: ThemeConfig().extraSpacing),
                SizedBox(
                  height: Get.size.height * .22,
                  child: ListView.builder(
                    reverse: false,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return MenuComponent(index: index);
                    },
                  ),
                ),
                Obx(() => GestureDetector(
                  onTap: () => controller.restaurantDetail.value.menu![indexCategory].item_menu![indexitem].menu_qty! == 0 ? null : controller.onAddMenu(
                      indexItem: indexitem, menuId: controller.restaurantDetail.value.menu![indexCategory].item_menu![indexitem].menu_id!, indexCategory: indexCategory),
                  child: Container(
                      padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                      margin: EdgeInsets.symmetric(
                          vertical: ThemeConfig().biggerSpacing),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: controller.restaurantDetail.value.menu![indexCategory].item_menu![indexitem].menu_qty! == 0 ? ThemeConfig.baseGrey : ThemeConfig.justBlack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0))),
                      child: Center(
                          child: Text('Add to cart',
                              style: ThemeConfig()
                                  .textHeader4(color: ThemeConfig.justWhite)))),
                ))
              ],
            ),
          ),
        ],
      ))),
    );
  }
}
