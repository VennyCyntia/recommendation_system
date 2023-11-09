import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/controller/employee_order_controller.dart';

class OrderNotPaidContainer extends GetView<EmployeeOrderController> {
  const OrderNotPaidContainer({Key? key}) : super(key: key);

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
                          onPressed: () => controller.onViewOrder(index: index, order_id: controller.lsOrder[index].order_id!, context: context),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ThemeConfig().defaultSpacing))),
                            primary: ThemeConfig.justWhite,
                            backgroundColor: ThemeConfig.justGrey,
                          ),
                          child: Text('Detail',
                              style: ThemeConfig()
                                  .textHeader5Bold(color: ThemeConfig.justBlack)),
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

class ShowPaymentInformation extends GetView<EmployeeOrderController> {
  int? index;
  ShowPaymentInformation({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: const Text('Your Payment Detail')),
      content: SizedBox(
        width: double.maxFinite,
        child: Wrap(
          children: [
            Column(
              children: [
                Text('Transaction Number', style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack)),
                Text(controller.detailOrder['order_id'], style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack)),
                BillPaymentComponent(title: 'Created date', subtitle: controller.detailOrder['bill_date']),
                BillPaymentComponent(title: 'Expired date', subtitle: controller.detailOrder['Expired_date']),
                SizedBox(height: ThemeConfig().biggerSpacing),
                Text('Detail Order', style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack)),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.lsOrder[index!].menu?.length,
                  itemBuilder: (context, indexItem) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(controller.lsOrder[index!].menu![indexItem].menu_qty.toString() + 'x'),
                          SizedBox(width: ThemeConfig().extraSpacing),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.lsOrder[index!].menu![indexItem].menu_name!),
                                Text(controller.lsOrder[index!].menu![indexItem].menu_price.toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack)),
                    Text(controller.lsOrder[index!].total_price.toString(), style: ThemeConfig().textHeader4Bold(color: ThemeConfig.justBlack)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () => controller.deleteOrder(orderId: controller.lsOrder[index!].order_id!),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().minSpacing)),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.red
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ThemeConfig().defaultSpacing, vertical: ThemeConfig().defaultSpacing ),
                  child: const Text(
                    'Delete From Order',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            ElevatedButton(
                onPressed: () => controller.onPayBill(orderId: controller.lsOrder[index!].order_id!),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().minSpacing)),
                  ),
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.green
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ThemeConfig().defaultSpacing, vertical: ThemeConfig().defaultSpacing ),
                  child: const Text(
                    'PAID',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ],
        )
      ],
    );
  }
}

class BillPaymentComponent extends StatelessWidget {
  String title;
  String subtitle;

  BillPaymentComponent({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            SizedBox(
              width: Get.size.width * .28,
              child: Wrap(
                children: [
                  Text(title),
                ],
              ),
            ),
          ],
        ),
        Text(':'),
        Flexible(child: Text(subtitle)),
      ],
    );
  }
}

