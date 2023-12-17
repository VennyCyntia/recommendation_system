import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/employee_order_controller.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/rating_container.dart';

class OrderProcessContainer extends GetView<EmployeeOrderController> {
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
                            backgroundColor: controller.lsOrder[index].status == 'WAITING FOOD' ? ThemeConfig.justGrey : Colors.green,
                          ),
                          child: Wrap(
                            children: [
                              Text(controller.lsOrder[index].status == 'WAITING FOOD' ? 'WAITING FOOD' : controller.lsOrder[index].status == 'FOOD IS READY' ? 'FOOD IS READY' : 'DONE',
                                  style: ThemeConfig().textHeader5Bold(color: ThemeConfig.justBlack)),
                            ],
                          ),
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

class ShowDetailOrderInformation extends GetView<EmployeeOrderController> {
  int index;
  ShowDetailOrderInformation({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeConfig.justWhite,
      title: const Center(child: Text('Detail Order' )),
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.lsOrder[index].menu?.length,
                  itemBuilder: (context, indexItem) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: ThemeConfig().minSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(controller.lsOrder[index].menu![indexItem].menu_qty.toString() + 'x'),
                          SizedBox(width: ThemeConfig().extraSpacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(controller.lsOrder[index].menu![indexItem].menu_name!),
                              Text(controller.lsOrder[index].menu![indexItem].menu_price.toString()),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: ThemeConfig().biggerSpacing),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total'),
                    Text(controller.lsOrder[index].total_price.toString()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Wrap(
          children: [
            ElevatedButton(
                onPressed: () {
                  controller.lsOrder[index].status == 'WAITING FOOD' ? SizedBox() : controller.onCheckListOrder(index: index);
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
