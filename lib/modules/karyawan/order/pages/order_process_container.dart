import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/order_controller.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/rating_container.dart';

class OrderProcessContainer extends GetView<OrderController> {
  const OrderProcessContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: controller.lsOrder.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                constraints: BoxConstraints(
                    maxHeight: Get.size.height * .125,
                    maxWidth: Get.size.width * .25
                ),
                decoration: const BoxDecoration(
                  color: ThemeConfig.justGrey,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.lsOrder[index].restaurant_name!,
                      style: ThemeConfig().textHeader3ExtraBold(
                          color: ThemeConfig.justBlack
                      ),
                    ),
                    SizedBox(height: ThemeConfig().biggerSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.lsOrder[index].queue_number.toString(),
                          style: ThemeConfig().textHeader2Bold(
                              color: ThemeConfig.justBlack
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => showDialog(context: context, builder: (context) => ShowDetailOrderInformation(index: index)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ThemeConfig().defaultSpacing))),
                            primary: ThemeConfig.justWhite,
                            backgroundColor: ThemeConfig.justGrey,
                          ),
                          child: Text('Paid',
                              style: ThemeConfig().textHeader5Bold(color: ThemeConfig.justBlack)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        );
      },
    ));
  }
}

class ShowDetailOrderInformation extends StatelessWidget {
  int? index;
  ShowDetailOrderInformation({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeConfig.justWhite,
      title: const Center(child: Text('Detail Order' )),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1x'),
                      Text('Nasi Goreng'),
                      Text('Rp 20.000'),
                    ],
                  ),
                );
              },
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total'),
                Text('Rp 20.000'),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        Wrap(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => const RatingContainer());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().minSpacing)),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: ThemeConfig.justGrey
                ),
                child: const Text(
                  'Rating',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        )
      ],
    );
  }
}
