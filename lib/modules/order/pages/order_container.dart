import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/order/pages/order_tabs_container.dart';

class OrderContainer extends StatelessWidget {
  const OrderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text('My order', style: ThemeConfig().textHeader3(color: Colors.black)),
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: const OrderTabsContainer(),
        )
    );
  }
}
