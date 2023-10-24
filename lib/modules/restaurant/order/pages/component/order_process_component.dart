import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class OrderProcessComponent extends StatelessWidget {
  const OrderProcessComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: ThemeConfig().defaultSpacing),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: ThemeConfig().biggerSpacing),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: ThemeConfig().defaultSpacing),
                constraints: BoxConstraints(
                    maxHeight: Get.size.height * .125,
                    maxWidth: Get.size.width * .25),
                decoration: const BoxDecoration(
                  color: ThemeConfig.justGrey,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Employee Name',
                      style: ThemeConfig()
                          .textHeader3ExtraBold(color: ThemeConfig.justBlack),
                    ),
                    SizedBox(height: ThemeConfig().biggerSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '15',
                          style: ThemeConfig()
                              .textHeader2Bold(color: ThemeConfig.justBlack),
                        ),
                        ElevatedButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) =>
                                  ShowDetailOrderInformation(index: index)),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ThemeConfig().defaultSpacing))),
                              primary: ThemeConfig.justWhite,
                              backgroundColor: ThemeConfig.justGrey,
                              padding: EdgeInsets.zero),
                          child: Text('Detail',
                              style: ThemeConfig().textHeader5Bold(
                                  color: ThemeConfig.justBlack)),
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

class ShowDetailOrderInformation extends StatelessWidget {
  int? index;

  ShowDetailOrderInformation({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeConfig.justWhite,
      title: const Center(child: Text('Detail Order')),
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
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) =>
                        ShowDoneInformation(index: index!)),
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    padding: EdgeInsets.zero,
                    backgroundColor: ThemeConfig.justGrey),
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        )
      ],
    );
  }
}

class ShowDoneInformation extends StatelessWidget {
  int index;
  ShowDoneInformation({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeConfig.justWhite,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Wrap(
        children: [
          Row(
            children: [
              Text(
                '15',
                style: ThemeConfig().textHeader1Bold(
                    color: ThemeConfig.justBlack
                ),
              ),
              SizedBox(width: ThemeConfig().biggerSpacing),
              Text(
                'IS THIS ORDER COMPLETE ??',
                style: ThemeConfig().textHeader5(
                    color: ThemeConfig.justBlack
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    padding: EdgeInsets.zero,
                    backgroundColor: ThemeConfig.justGrey),
                child: const Text(
                  'NO',
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () => ShowConfirmationInformation(index: index),
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    padding: EdgeInsets.zero,
                    backgroundColor: ThemeConfig.justGrey),
                child: const Text(
                  'YES',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        )
      ],
    );
  }
}

class ShowConfirmationInformation extends StatelessWidget {
  int index;
  ShowConfirmationInformation({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeConfig.justWhite,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Wrap(
        children: [
          Row(
            children: [
              Text(
                '15',
                style: ThemeConfig().textHeader1Bold(
                    color: ThemeConfig.justBlack
                ),
              ),
              Text(
                'This Order Successfully Done!',
                style: ThemeConfig().textHeader5(
                    color: ThemeConfig.justBlack
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

