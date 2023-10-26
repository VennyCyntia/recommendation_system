import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/order_controller.dart';

class RatingContainer extends GetView<OrderController> {
  const RatingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rating item',
              style: ThemeConfig().textHeader3(color: Colors.black),
            ),
            TextButton(
                onPressed: (){},
                child: Text('Send',
                    style: ThemeConfig().textHeader5(color: Colors.black)))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  constraints: BoxConstraints(
                      maxHeight: Get.size.height * .1,
                      maxWidth: Get.size.width * .2),
                  decoration: const BoxDecoration(
                    color: ThemeConfig.justGrey,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem Ipsum',
                        style: ThemeConfig()
                            .textHeader3ExtraBold(color: ThemeConfig.justBlack),
                      ),
                      SizedBox(height: ThemeConfig().extra2Spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kualitas produk',
                            style: ThemeConfig()
                                .textHeader5(color: ThemeConfig.justBlack),
                          ),
                          StarComponent(index: index),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

  class StarComponent extends GetView<OrderController> {
  int index;
  StarComponent({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar(
            initialRating: 0,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 25,
            minRating: 1,
            maxRating: 5,
            ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: Colors.orange),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.orange,
                ),
                empty: const Icon(
                  Icons.star_outline,
                  color: Colors.orange,
                )),
            onRatingUpdate: (value) {
             controller.onGiveRating(index, value.toInt());
            }),
      ]
    );
  }
}
