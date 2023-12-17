import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class RestaurantPage extends GetView<RestaurantController> {
  int id;

  RestaurantPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() =>
        controller.isLoading.value == true ? DialogConfig().onShowBasicLoading() : Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 40,
                    child: Container(
                      constraints: BoxConstraints(minWidth: Get.size.width),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage(
                                      'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg'),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ThemeConfig().biggerSpacing,
                            horizontal: ThemeConfig().extraSpacing),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.all(ThemeConfig().defaultSpacing),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ThemeConfig.justWhite,
                              ),
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(Icons.arrow_back, size: 28),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 30,
                    right: 30,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ThemeConfig().biggerSpacing,
                          vertical: ThemeConfig().biggerSpacing),
                      decoration: BoxDecoration(
                          color: ThemeConfig.justBlack,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [ThemeConfig().onSetDefaultShadow()]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  controller
                                      .restaurantDetail.value.restaurant_name!,
                                  style: ThemeConfig().text1ExtraBold(
                                      color: ThemeConfig.justGrey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
              child: TextFormField(
                controller: controller.findFood,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                          Radius.circular(ThemeConfig().defaultSpacing))),
                  hintText: 'Find Your Food',
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
                onChanged: (value) => controller.onFindRestaurant('food',value),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ThemeConfig().biggerSpacing),
              child: Text('Menu',
                  style: ThemeConfig()
                      .textHeader2Bold(color: ThemeConfig.justBlack)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ThemeConfig().biggerSpacing),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              controller.foundMenu.value.length,
                          itemBuilder: (context, indexCategory) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.foundMenu[indexCategory].menu_category
                                      .toString(),
                                  style: ThemeConfig().textHeader2ExtraBold(
                                      color: ThemeConfig.justBlack),
                                ),
                                Obx(() => GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 2.75 / 3,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 20,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.foundMenu[indexCategory].item_menu!.length,
                                    itemBuilder: (BuildContext ctx, indexItem) {
                                      return GestureDetector(
                                        onTap: () => controller.onToMenuContainer(menu_id: controller.foundMenu[indexCategory].item_menu![indexItem].menu_id!),
                                        child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: const Offset(0, 1),
                                                  )
                                                ],
                                                border: Border.all(
                                                    color: Colors.grey.shade400,
                                                    width: 1.5),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child:
                                                  Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg')
                                                  // Image.memory(
                                                  //   controller.foundMenu[indexCategory].item_menu![indexItem].menu_image!,
                                                  //     // controller
                                                  //     //     .restaurantDetail
                                                  //     //     .value
                                                  //     //     .menu![indexCategory]
                                                  //     //     .item_menu![indexItem]
                                                  //     //     .menu_image!,
                                                  //     fit: BoxFit.cover),
                                                ),
                                                Wrap(
                                                  children: [
                                                    Text(controller.foundMenu[indexCategory].item_menu![indexItem].menu_name!),
                                                  ],
                                                ),
                                                Text(controller.foundMenu[indexCategory].item_menu![indexItem].menu_price!
                                                    .toString())
                                              ],
                                            )),
                                      );
                                    })),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
