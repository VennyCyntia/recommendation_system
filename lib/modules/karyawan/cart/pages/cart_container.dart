import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';

class CartContainer extends GetView<CartController> {
  const CartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('My cart', style: ThemeConfig().textHeader3(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Obx(() => ListView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: controller.lsItemCart.length,
          shrinkWrap: true,
          itemBuilder: (context, index){
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.lsItemCart[index].restaurant_name!.toUpperCase(), style: ThemeConfig().textHeader3(color: ThemeConfig.justBlack)),
                  ],
                ),
                ListRestaurant(index: index),
                SizedBox(height: ThemeConfig().extra2Spacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Total:', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack)),
                        Text(controller.lsTotalPrice[index].toString(), style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack)),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () => controller.onCheckOutCart(indexRestaurant: index),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeConfig.justGrey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().defaultSpacing)))
                          ),
                          child: Text('Checkout', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack))),
                    ),
                  ],
                ),
                SizedBox(height: ThemeConfig().extraSpacing),
                const Divider(height: 1)
              ],
            );
          })),
    );
  }
}

class ListRestaurant extends GetView<CartController> {
  int index;
  ListRestaurant({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var restaurantController = Get.find<RestaurantController>();
    return Obx(() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.lsItemCart[index].menu!.length,
        itemBuilder: (context, indexItem){
          return Column(
            children: [
              SizedBox(height: ThemeConfig().extraSpacing),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Obx(() => Checkbox(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().minSpacing))),
                          checkColor: ThemeConfig.justWhite,
                          activeColor: ThemeConfig.justBlack,
                          value: controller.lsItemCart[index].menu![indexItem].checkbox!,
                          onChanged: (bool? value){
                            controller.lsItemCart[index].menu![indexItem].checkbox = value;
                            controller.lsItemCart.refresh();
                          }),
                      ),
                      IconButton(onPressed: () => controller.onDeleteMenuById(id: controller.lsItemCart[index].menu![indexItem].menu_id!), icon: Icon(Icons.delete))
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(right: ThemeConfig().defaultSpacing),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400, width: 1.5),
                          color: Colors.white),
                      child: SizedBox.fromSize(size: const Size.fromRadius(50),child: Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg', fit: BoxFit.cover))
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.lsItemCart[index].menu![indexItem].menu_name!),
                        SizedBox(height: ThemeConfig().extra2Spacing),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${controller.lsItemCart[index].menu![indexItem].menu_qty}x',style: ThemeConfig().textHeader4(color: ThemeConfig.baseGrey)),
                            GestureDetector(
                              onTap: () => restaurantController.onToMenuContainer(menu_id: controller.lsItemCart[index].menu![indexItem].menu_id!),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().defaultSpacing)),
                                  color: ThemeConfig.lightGrey,
                                ),
                                child: Text('Edit',
                                    style: ThemeConfig().textHeader5Bold(
                                        color: ThemeConfig.justWhite)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),

            ],
          );
        }));
  }
}
