import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/admin/pages/karyawan_container.dart';
import 'package:recommendation_system/modules/admin/pages/tenant_container.dart';
import 'package:recommendation_system/modules/admin/controller/admin_tabs_controller.dart';

class AdminContainer extends StatelessWidget {
  const AdminContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            top: kMinInteractiveDimension,
            left: ThemeConfig().extraSpacing,
            right: ThemeConfig().extraSpacing,
        ),
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: ThemeConfig.justBlack)
                ),
                child: TabBar(
                    unselectedLabelColor: ThemeConfig.lightGrey,
                    controller: Get.find<AdminTabsController>().controller,
                    tabs: Get.find<AdminTabsController>().tabs,
                    indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: Colors.black)),
                    indicatorPadding: const EdgeInsets.all(8.0),
                    dividerColor: Colors.black,
                    labelColor: Colors.black,
                    labelStyle: ThemeConfig().textHeader5Bold(color: Colors.grey)
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: Get.find<AdminTabsController>().controller,
                children: const [
                  KaryawanContainer(),
                  TenantContainer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
