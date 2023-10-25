import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/home/components/menu_component.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class MenuContainer extends GetView<RestaurantController> {
  int indexRestaurant;
  int indexCategory;
  int index;
  MenuContainer({super.key, required this.index, required this.indexCategory, required this.indexRestaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image.network(controller.lsRestaurantMenu[indexRestaurant].menu![indexCategory].itemMenu![index].pic!, width: double.maxFinite, fit: BoxFit.fitWidth),
              Padding(
                padding: EdgeInsets.symmetric(vertical: ThemeConfig().defaultSpacing, horizontal: ThemeConfig().biggerSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(controller.lsRestaurantMenu[indexRestaurant].menu![indexCategory].itemMenu![index].title!, style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack)),
                        // Text(controller.lsRestaurantMenu[indexRestaurant].menu![indexCategory].itemMenu![index].price!.toString(), style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack))
                      ],
                    ),
                    SizedBox(height: ThemeConfig().extraSpacing),
                    // Text(textAlign: TextAlign.justify, controller.lsRestaurantMenu[indexRestaurant].menu![indexCategory].itemMenu![index].subtitle!),
                    // Obx(() => controller.lsRestaurantMenu[indexRestaurant].menu![indexCategory].itemMenu![index].qty! == 0 ? GestureDetector(
                    //   onTap: () => controller.onAddMenu(indexItem: index, indexRestaurant: indexRestaurant, indexCategory: indexCategory),
                    //   child: Container(
                    //     padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                    //     margin: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
                    //     width: double.infinity,
                    //     decoration: const BoxDecoration(
                    //         color: ThemeConfig.justBlack,
                    //         borderRadius: BorderRadius.all(Radius.circular(20.0))
                    //     ),
                    //     child: Center(child: Text('Add to cart', style: ThemeConfig().textHeader4(color: ThemeConfig.justWhite)))
                    //   ),
                    // ) :
                    // Container(
                    //   margin: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
                    //   decoration: const BoxDecoration(
                    //     color: ThemeConfig.justBlack,
                    //     borderRadius: BorderRadius.all(Radius.circular(20.0))
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       IconButton(
                    //           onPressed: () => controller.onChangeItem(indexItem: index, indexRestaurant: indexRestaurant, type:  'decrease', indexCategory:  indexCategory),
                    //           icon: const Icon(Icons.remove, color: ThemeConfig.justWhite)),
                    //       // Text(controller.lsRestaurantMenu[indexRestaurant].menu![indexCategory].itemMenu![index].qty!.toString(), style: ThemeConfig().textHeader1ExtraBold(color: ThemeConfig.justWhite)),
                    //       IconButton(
                    //           onPressed: () => controller.onChangeItem(indexItem: index, indexRestaurant: indexRestaurant, type:  'increase', indexCategory:  indexCategory),
                    //           icon: const Icon(Icons.add, color: ThemeConfig.justWhite)),
                    //     ],
                    //   ),
                    // )),
                    SizedBox(height: ThemeConfig().extraSpacing),
                    Text('Similar Items', style: ThemeConfig().textHeader3Bold(color: ThemeConfig.justBlack)),
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
                  ],
                ),
              ),

            ],
          )

        )
      ),
    );
  }
}
