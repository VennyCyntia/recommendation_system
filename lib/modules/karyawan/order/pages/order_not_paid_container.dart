import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class OrderNotPaidContainer extends StatelessWidget {
  const OrderNotPaidContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: 4,
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
                      'Lorem Ipsum',
                      style: ThemeConfig().textHeader3ExtraBold(
                          color: ThemeConfig.justBlack
                      ),
                    ),
                    SizedBox(height: ThemeConfig().biggerSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '15',
                          style: ThemeConfig().textHeader2Bold(
                              color: ThemeConfig.justBlack
                          ),
                        ),
                        ElevatedButton(
                          child: Text('Paid',
                              style: ThemeConfig()
                                  .textHeader5Bold(color: ThemeConfig.justBlack)),
                          onPressed: () => showDialog(context: context, builder: (context) => ShowPaymentInformation(index: index)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(ThemeConfig().defaultSpacing))),
                            primary: ThemeConfig.justWhite,
                            backgroundColor: ThemeConfig.justGrey,
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
    );
  }
}

class ShowPaymentInformation extends StatelessWidget {
  int? index;
  ShowPaymentInformation({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: const Text('Your Payment Detail')),
      content: const Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().minSpacing)),
              ),
              padding: EdgeInsets.zero,
              backgroundColor: ThemeConfig.justGrey
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ThemeConfig().defaultSpacing, vertical: ThemeConfig().defaultSpacing ),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
  }
}
