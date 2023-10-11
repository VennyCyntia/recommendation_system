import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/cart/pages/cart_checkout_container.dart';

class CartContainer extends StatelessWidget {
  const CartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('My cart', style: ThemeConfig().textHeader3(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return ListRestaurant(index: index);
        }),
    );
  }
}

class ListRestaurant extends GetView<CartContainer> {
  int? index;
  ListRestaurant({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, index){
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Restaurant Name', style: ThemeConfig().textHeader3(color: ThemeConfig.justBlack)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.close))
              ],
            ),
            SizedBox(height: ThemeConfig().extraSpacing),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(value: isBlank, onChanged: (bool? value){}),
                Container(
                    margin: EdgeInsets.only(right: ThemeConfig().defaultSpacing),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400, width: 1.5),
                        color: Colors.white),
                    child: SizedBox.fromSize(size: Size.fromRadius(50),child: Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg', fit: BoxFit.cover))
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Food Name'),
                      SizedBox(height: ThemeConfig().extra2Spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                    color: ThemeConfig.baseGrey,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0))
                                ),
                                child: const Icon(Icons.remove,
                                    color: ThemeConfig.justWhite)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            color: Colors.grey,
                            child: Text('1',
                                style: ThemeConfig().textHeader3Bold(
                                    color: ThemeConfig.justWhite)),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: const BoxDecoration(
                                    color: ThemeConfig.baseGrey,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.0), bottomRight: Radius.circular(8.0))
                                ),
                                child: const Icon(Icons.add,
                                    color: ThemeConfig.justWhite)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: ThemeConfig().extra2Spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Total:', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack)),
                    Text('50.000', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack)),
                  ],
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      onPressed: () => Get.to(() => CheckoutContainer()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeConfig.justGrey,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().defaultSpacing)))
                      ),
                      child: Text('Checkout', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack))),
                ),
              ],
            ),
            SizedBox(height: ThemeConfig().extraSpacing),
            const Divider(height: 1)
          ],
        );
      });
  }
}
