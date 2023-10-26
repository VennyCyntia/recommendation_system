import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/home/components/menu_component.dart';
import 'package:recommendation_system/modules/karyawan/home/controller/restaurant_controller.dart';

class MenuContainer extends GetView<RestaurantController> {
  int indexCategory;
  int index;
  int id;

  MenuContainer(
      {super.key,
      required this.id,
      required this.index,
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
                    Text(controller.restaurantDetail.value.menu![indexCategory].item_menu![index].menu_name!, style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack)),
                    Text(controller.restaurantDetail.value.menu![indexCategory].item_menu![index].menu_price!.toString(), style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack))
                  ],
                ),
                SizedBox(height: ThemeConfig().extraSpacing),
                Text(textAlign: TextAlign.justify, controller.restaurantDetail.value.menu![indexCategory].item_menu![index].menu_subtitle!),
                Obx(() => controller.restaurantDetail.value.menu![indexCategory].item_menu![index].menu_qty! == 0 ? GestureDetector(
                  onTap: () => controller.onAddMenu(indexItem: index, id: id, indexCategory: indexCategory),
                  child: Container(
                    padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                    margin: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: ThemeConfig.justBlack,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                    ),
                    child: Center(child: Text('Add to cart', style: ThemeConfig().textHeader4(color: ThemeConfig.justWhite)))
                  ),
                ) :
                Container(
                  margin: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
                  decoration: const BoxDecoration(
                    color: ThemeConfig.justBlack,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => controller.onChangeItem(indexItem: index, id: id, type:  'decrease', indexCategory:  indexCategory),
                          icon: const Icon(Icons.remove, color: ThemeConfig.justWhite)),
                      Text(controller.restaurantDetail.value.menu![indexCategory].item_menu![index].menu_qty!.toString(), style: ThemeConfig().textHeader1ExtraBold(color: ThemeConfig.justWhite)),
                      IconButton(
                          onPressed: () => controller.onChangeItem(indexItem: index, id: id, type:  'increase', indexCategory:  indexCategory),
                          icon: const Icon(Icons.add, color: ThemeConfig.justWhite)),
                    ],
                  ),
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
              ],
            ),
          ),
        ],
      ))),
    );
  }
}
