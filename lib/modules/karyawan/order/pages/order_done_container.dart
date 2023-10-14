import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class OrderDoneContainer extends StatelessWidget {
  const OrderDoneContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(
                top: ThemeConfig().minSpacing,
                right: ThemeConfig().extraSpacing,
                bottom: ThemeConfig().extraSpacing),
            child: ListTile(
              leading: Container(
                constraints: BoxConstraints(
                    minHeight: Get.size.height * .25,
                    maxWidth: Get.size.width * .2
                ),
                decoration: const BoxDecoration(
                  color: ThemeConfig.justGrey,
                ),
              ),
              title: Text(
                'Lorem Ipsum',
                style: ThemeConfig().textHeader3ExtraBold(
                    color: ThemeConfig.justBlack
                ),
              ),
              subtitle: Text(
                '15',
                style: ThemeConfig().textHeader2Bold(
                    color: ThemeConfig.justBlack
                ),
              ),
            )
        );
      },
    );
  }
}
