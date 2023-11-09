import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/components/menu_component.dart';
import 'package:recommendation_system/modules/karyawan/home/components/restaurant_component.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class HomeContainer extends GetView<RestaurantController> {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      print('masuk');
      await controller.onSetUpMenu();
    });

    return SafeArea(
      child: Scaffold(
        body: Obx(() => controller.isLoading.value == true ? DialogConfig().onShowBasicLoading() : Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended For You', style: ThemeConfig().textHeader3Bold(color: ThemeConfig.justBlack)),
                  IconButton(onPressed: () => controller.onSetUpMenu(), icon: const Icon(Icons.refresh)),
                ],
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: Get.size.height * .28,
                child: Obx(() => ListView.builder(
                  reverse: false,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: controller.recommendationMenu.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MenuComponent(index: index);
                  },
                )),
              ),
              // Expanded(
              //   child: Obx(() => GridView.builder(
              //       padding: const EdgeInsets.symmetric(
              //           vertical: 15.0),
              //       gridDelegate:
              //       const SliverGridDelegateWithMaxCrossAxisExtent(
              //         maxCrossAxisExtent: 200,
              //         childAspectRatio: 2.75 / 3,
              //         crossAxisSpacing: 30,
              //         mainAxisSpacing: 20,
              //       ),
              //       // physics:
              //       // const AlwaysScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       itemCount: controller.recommendationMenu.length,
              //       itemBuilder: (BuildContext ctx, indexItem) {
              //         return MenuComponent(index: indexItem, restaurantId: controller.recommendationMenu[indexItem]['restaurant_id'],);
              //       })),
              // ),
              const SizedBox(height: 8.0),
              Wrap(
                children: [
                  TextFormField(
                    controller: controller.findRestaurant,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Find Your Restaurant',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                    onChanged: (value) => controller.onFindRestaurant('restaurant',value),
                  ),
                ],
              ),
              Text('Restaurant', style: ThemeConfig().textHeader3Bold(color: ThemeConfig.justBlack)),
              Expanded(
                child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.foundRestaurant.length,
                  itemBuilder: (context, index) {
                    return RestaurantComponent(id: controller.foundRestaurant[index].restaurant_id!, index: index);
                  },
                )),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
