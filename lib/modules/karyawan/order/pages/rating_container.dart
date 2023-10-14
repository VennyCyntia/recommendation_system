import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class RatingContainer extends StatelessWidget {
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
                onPressed: () {},
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
                          const StarComponent(),
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

class StarComponent extends StatelessWidget {
  const StarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
            onTap: (){},
            child: const Icon(Icons.star_border_outlined));
      }),
    );
  }
}
