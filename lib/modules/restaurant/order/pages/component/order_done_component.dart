import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class OrderDoneComponent extends StatelessWidget {
  const OrderDoneComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only( right: ThemeConfig().defaultSpacing),
                constraints: BoxConstraints(
                    maxHeight: Get.size.height * .125,
                    maxWidth: Get.size.width * .25
                ),
                decoration: const BoxDecoration(
                  color: ThemeConfig.justGrey,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lorem Ipsum',
                    style: ThemeConfig().textHeader3ExtraBold(
                        color: ThemeConfig.justBlack
                    ),
                  ),
                  SizedBox(height: ThemeConfig().biggerSpacing),
                  Text(
                    '15',
                    style: ThemeConfig().textHeader2Bold(
                        color: ThemeConfig.justBlack
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
