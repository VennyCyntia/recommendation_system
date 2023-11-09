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
        title: Text('Confirmation',
            style: ThemeConfig().textHeader3(color: Colors.black)),
        backgroundColor: ThemeConfig.justWhite,
      ),
      body: Wrap(
        children: [
          Container(
            padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
            margin: EdgeInsets.all(ThemeConfig().defaultSpacing),
            decoration: BoxDecoration(
                border: Border.all(color: ThemeConfig.justBlack),
                borderRadius: BorderRadius.all(
                    Radius.circular(ThemeConfig().defaultSpacing))),
            child: Column(
              children: [
                Text('Orderan berhasil !',
                    style: ThemeConfig()
                        .textHeader4Bold(color: ThemeConfig.justBlack)),
                SizedBox(height: ThemeConfig().defaultSpacing),
                const Text(
                    textAlign: TextAlign.center,
                    'Silahkan melakukan pembayaran dengan menuju halaman orderan anda untuk melihat detail pembayaran anda'),
                SizedBox(height: ThemeConfig().defaultSpacing),
                ElevatedButton(
                    onPressed: () async => controller.onRefreshData(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConfig.justBlack,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)))),
                    child: Text('Back To Home',
                        style: ThemeConfig()
                            .textHeader6(color: ThemeConfig.justWhite))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
