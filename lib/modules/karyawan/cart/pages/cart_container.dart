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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Restaurant Name', style: ThemeConfig().textHeader3(color: ThemeConfig.justBlack)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.close))
          ],
        ),
        SizedBox(height: ThemeConfig().extraSpacing),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index){
            return Row(
              children: [
                Checkbox(value: isBlank, onChanged: (bool? value){}),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(right: ThemeConfig().defaultSpacing),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400, width: 1.5),
                            color: Colors.white),
                        child: Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg', height: Get.size.height * .125)
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Food Name'),
                        SizedBox(height: ThemeConfig().extra2Spacing),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: ThemeConfig.justGrey,
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () { },
                              ),
                              Text('1'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
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
  }
}
