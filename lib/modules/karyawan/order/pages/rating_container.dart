import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/employee_order_controller.dart';

class RatingContainer extends GetView<EmployeeOrderController> {
  int index;
  RatingContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, (){
    //   // controller.isLoading.value == true;
    //
    //   // controller.isLoading.value == false;
    // });

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
                onPressed: () => controller.onSaveRating(orderId: controller.lsOrder[index].order_id!),
                child: Text('Send',
                    style: ThemeConfig().textHeader5(color: Colors.black)))
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(() => controller.isLoading.isTrue ? DialogConfig().onShowBasicLoading() :Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.lsOrder[index].menu?.length,
            itemBuilder: (context, indexItem) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
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
                          // child: SizedBox.fromSize(
                          //     size: const Size.fromRadius(40),
                          //     child: Image.memory(controller.lsOrder[index].menu![indexItem]., fit: BoxFit.fill)),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.lsOrder[index].menu![indexItem].menu_name!,
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
                                  StarComponent(index: indexItem),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 8.0, right: 4.0),
                      child: TextFormField(
                        controller: controller.lsComment[index],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8.0),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: ThemeConfig.lightGrey)),
                          hintText: 'Commment about that food ',
                          hintStyle: ThemeConfig().textHeader4(color: ThemeConfig.baseGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(alignment: Alignment.bottomCenter, child: Text(textAlign: TextAlign.justify,'Rating yang anda berikan mempengaruhi rekomendasi makanan yang akan diberikan kepada anda', style: ThemeConfig().textHeader5Bold(color: ThemeConfig.justRed))),
          ))
        ],
      )),
    );
  }
}

  class StarComponent extends GetView<EmployeeOrderController> {
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
             controller.onSetRating(index, value.toInt());
            }),
      ]
    );
  }
}
