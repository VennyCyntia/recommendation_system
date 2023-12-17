import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/admin/controller/admin_employee_controller.dart';
import 'package:recommendation_system/modules/admin/pages/component/add_description_component.dart';
import 'package:recommendation_system/modules/admin/pages/component/add_karyawan_component.dart';

class KaryawanContainer extends GetView<AdminEmployeeController> {
  const KaryawanContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() => ListView.builder(
            itemCount: controller.lsEmployee.value.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){},
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.lsEmployee[index].username!,style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack)),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => controller.onDeleteData(id: controller.lsEmployee[index].user_id!),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ThemeConfig().defaultSpacing),
                                  backgroundColor: ThemeConfig.justRed,
                                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                              child: Text('Delete', style: ThemeConfig().textHeader5(color: ThemeConfig.justBlack)),
                            ),
                            SizedBox(width: ThemeConfig().defaultSpacing),
                            ElevatedButton(
                              onPressed: () => controller.onShowEditMenu(id: controller.lsEmployee[index].user_id!),
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
                ),
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
                      label: 'Add Karyawan',
                      onTap: () => Get.to(() => const AddKaryawanComponent()),
                    ),
                    SpeedDialChild(
                      label: 'Tambah deskripsi',
                      onTap: () => Get.to(() => const AddDescription()),
                    ),
                  ],
                )
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                    onPressed: () async => await DialogConfig().onLogoutDialog(title: 'LOGOUT', content: 'Yakin ingin logout?'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: ThemeConfig().defaultSpacing),
                        backgroundColor: ThemeConfig.justGrey,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                    child: Text('Logout', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
