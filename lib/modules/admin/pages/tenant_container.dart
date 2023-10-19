import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/admin/pages/component/add_tenant_component.dart';
import 'package:recommendation_system/modules/admin/controller/admin_restaurant_controller.dart';

class TenantContainer extends GetView<AdminRestaurantController>{
  const TenantContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() => ListView.builder(
            itemCount: controller.lsRestaurant.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.lsRestaurant[index].restaurantname!,style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack)),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => controller.onDeleteData(id: controller.lsRestaurant[index].id!),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ThemeConfig().defaultSpacing),
                                backgroundColor: ThemeConfig.justRed,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                            child: Text('Delete', style: ThemeConfig().textHeader5(color: ThemeConfig.justBlack)),
                          ),
                          SizedBox(width: ThemeConfig().defaultSpacing),
                          ElevatedButton(
                            onPressed: () => controller.onShowEditData(index: index, id: controller.lsRestaurant[index].id!),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: ThemeConfig().defaultSpacing),
                                backgroundColor: ThemeConfig.baseGrey,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                            child: Text('Edit', style: ThemeConfig().textHeader5(color: ThemeConfig.justBlack)),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Divider(color: ThemeConfig.justGrey),
                ],
              );
            },)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
                onPressed: (){},
                elevation: 0,
                shape: const CircleBorder(),
                child: SpeedDial(
                  icon: Icons.add,
                  children: [
                    SpeedDialChild(
                      label: 'Add Tenant',
                      onTap: () => Get.to(() => const AddTenantComponent()),
                    ),
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
}
