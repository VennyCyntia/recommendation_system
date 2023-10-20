import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';

class RestaurantPage extends GetView<RestaurantController> {
  int? indexRestaurant;
  RestaurantPage({super.key, this.indexRestaurant});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 40,
                    child: Container(
                      constraints: BoxConstraints(
                          minWidth: Get.size.width),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                                  image: NetworkImage(controller.lsRestaurantMenu[indexRestaurant!].pic!),
                              fit: BoxFit.cover)),
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
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [ThemeConfig().onSetDefaultShadow()]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(controller.lsRestaurantMenu[indexRestaurant!].restaurantName!.toUpperCase(),
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
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().defaultSpacing))),
                  hintText: 'Find Your Food',
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ThemeConfig().biggerSpacing),
              child: Text('Menu', style: ThemeConfig().textHeader2Bold(color: ThemeConfig.justBlack)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ThemeConfig().biggerSpacing),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.lsRestaurantMenu[indexRestaurant!].menu!.length,
                          itemBuilder: (context, indexCategory) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.lsRestaurantMenu[indexRestaurant!].menu![indexCategory].category.toString(),
                                  style: ThemeConfig()
                                      .textHeader2ExtraBold(color: ThemeConfig.justBlack),
                                ),
                                GridView.builder(
                                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 2.75 / 3,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 20,
                                    ),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.lsRestaurantMenu[indexRestaurant!].menu![indexCategory].itemMenu!.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      return GestureDetector(
                                        onTap: () => Get.to(() => MenuContainer(indexCategory: indexCategory, indexRestaurant: indexRestaurant!, index: index)),
                                        child: Container(
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
                                                borderRadius: BorderRadius.circular(10)),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                ClipRRect(borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().defaultSpacing)),child: Image.network(controller.lsRestaurantMenu[indexRestaurant!].menu![indexCategory!].itemMenu![index].pic!, )),
                                                Wrap(
                                                  children: [
                                                    Text(controller.lsRestaurantMenu[indexRestaurant!].menu![indexCategory!].itemMenu![index].title!),
                                                  ],
                                                ),
                                                Text(controller.lsRestaurantMenu[indexRestaurant!].menu![indexCategory!].itemMenu![index].price!.toString())
                                              ],
                                            )
                                        ),
                                      );
                                    }),
                              ],
                            );
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
