import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/Routes/app_routes.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/employee_order_controller.dart';

class ConfirmationContainer extends GetView<CartController> {
  const ConfirmationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.justWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Confirmation', style: ThemeConfig().textHeader3(color: Colors.black)),
        backgroundColor: ThemeConfig.justWhite,
      ),
      body: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
            margin: EdgeInsets.all(ThemeConfig().defaultSpacing),
            decoration: BoxDecoration(
              border: Border.all(color: ThemeConfig.justBlack),
              borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().defaultSpacing))
            ),
            child: Column(
              children: [
                const Text('Your Order Has Been Confirm'),
                const Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.'),
                ElevatedButton(
                    onPressed: () async => controller.onRefreshData(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConfig.justBlack,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))
                    ),
                    child: Text('Back To Home', style: ThemeConfig().textHeader6(color: ThemeConfig.justWhite))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
