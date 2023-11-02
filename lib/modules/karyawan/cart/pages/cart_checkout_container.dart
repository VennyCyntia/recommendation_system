import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_confirmation_container.dart';

class CheckoutContainer extends GetView<CartController> {
  int? index;

  CheckoutContainer({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.justWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Checkout',
            style: ThemeConfig().textHeader3(color: Colors.black)),
        backgroundColor: ThemeConfig.justWhite,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(controller.lsCheckOutItem.restaurant_name!,
                  style:
                      ThemeConfig().textHeader3(color: ThemeConfig.justBlack)),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: ThemeConfig().biggerSpacing),
                  itemCount: controller.lsCheckOutItem.menu!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListMenu(index: index);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',
                      style: ThemeConfig()
                          .textHeader4(color: ThemeConfig.justBlack)),
                  Text(controller.totalPrice.toString(),
                      style: ThemeConfig()
                          .textHeader4Bold(color: ThemeConfig.justBlack))
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.onCreateBill(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConfig.justBlack, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                    child: Text('Place Order',
                        style: ThemeConfig()
                            .textHeader4(color: ThemeConfig.justWhite))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListMenu extends GetView<CartController> {
  int? index;

  ListMenu({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                      color: Colors.white),
                  child: SizedBox.fromSize(size: const Size.fromRadius(50),child: Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg', fit: BoxFit.cover))),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.lsCheckOutItem.menu![index!].menu_name!),
                    SizedBox(height: ThemeConfig().biggerSpacing),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(controller.lsCheckOutItem.menu![index!].menu_qty.toString(),
                          style:
                          ThemeConfig().textHeader4(color: ThemeConfig.justBlack)),
                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: ThemeConfig().biggerSpacing),
          TextFormField(
            controller: controller.lsNotes[index!],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: ThemeConfig.lightGrey)),
              hintText: 'Notes: ',
              hintStyle: ThemeConfig().textHeader4(color: ThemeConfig.baseGrey),
            ),
          )
        ],
      ),
    );
  }
}
