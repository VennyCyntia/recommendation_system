import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/employee_profile_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/menu_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/component/text_field_input_component.dart';

class ProfileContainer extends GetView<EmployeeProfileController> {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var restaurantMenuController = Get.find<RestaurantMenuController>().obs;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConfig.justGrey,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  Container(
                    padding: EdgeInsets.all(ThemeConfig().extra2Spacing),
                    constraints: BoxConstraints(
                      maxWidth: Get.size.width
                    ),
                    decoration: const BoxDecoration(color: ThemeConfig.justGrey),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const CircleAvatar(
                          maxRadius: 70,
                          child: Icon(Icons.account_circle_sharp),
                        ),
                        SizedBox(height: ThemeConfig().defaultSpacing),
                        Center(child: Text(controller.username.text.toUpperCase(),
                            style: ThemeConfig().textHeader4Bold(
                                color: ThemeConfig.justBlack)))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ThemeConfig().defaultSpacing),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ElevatedButton.icon(
                      onPressed: () => showDialog(context: context, builder: (context) => TopUpContainer()),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: ThemeConfig().minSpacing),
                          backgroundColor: ThemeConfig.justBlack,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                      icon: Icon(Icons.add, color: ThemeConfig.justWhite),
                      label: Text('TOP UP', style: ThemeConfig().textHeader5(color: ThemeConfig.justWhite)),
                  ),
                ),
              ),
              FormInputTextMandatory(
                title: 'Nama',
                txtcontroller: controller.username,
                textInputType: TextInputType.text,
                txtLine: 2,
                txtEnable: true,
                txtReadonly: false,
                mandatory: false,
                borderColors: Colors.black,
                pLeft: ThemeConfig().defaultSpacing,
                pTop: ThemeConfig().extraSpacing,
                pRight: ThemeConfig().defaultSpacing,
                pBottom: ThemeConfig().defaultSpacing,
              ),
              FormInputTextMandatory(
                title: 'Email',
                txtcontroller: controller.email,
                textInputType: TextInputType.text,
                txtLine: 2,
                txtEnable: true,
                txtReadonly: true,
                mandatory: false,
                borderColors: Colors.black,
                pLeft: ThemeConfig().defaultSpacing,
                pTop: ThemeConfig().extraSpacing,
                pRight: ThemeConfig().defaultSpacing,
                pBottom: ThemeConfig().defaultSpacing,
              ),
              FormInputTextMandatory(
                title: 'Preferensi',
                txtcontroller: controller.preference,
                textInputType: TextInputType.text,
                txtLine: 2,
                txtEnable: true,
                txtReadonly: false,
                mandatory: false,
                borderColors: Colors.black,
                pLeft: ThemeConfig().defaultSpacing,
                pTop: ThemeConfig().extraSpacing,
                pRight: ThemeConfig().defaultSpacing,
                pBottom: ThemeConfig().defaultSpacing,
              ),
              // GridView.builder(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 2,
              //         crossAxisSpacing: ThemeConfig().defaultSpacing,
              //         mainAxisSpacing: 1.0,
              //         childAspectRatio: 2.5 / 1),
              //     itemCount: 4,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           Align(
              //               alignment: Alignment.topLeft,
              //               child: RichText(
              //                 text: TextSpan(
              //                   text: 'Preferensi ',
              //                   style: ThemeConfig().textHeader4Thin(color: Colors.black),
              //                   children: <TextSpan>[
              //                     TextSpan(
              //                         text: '*',
              //                         style:
              //                         ThemeConfig().textHeader5(color: Colors.red)),
              //                   ],
              //                 ),
              //               )),
              //           Expanded(
              //             child: DropdownButtonFormField<String>(
              //                 validator: (String? value) {
              //                   if (value == '') {
              //                     return 'Mohon mengisi semua kolom dengan benar';
              //                   }
              //                   return null;
              //                 },
              //                 padding: EdgeInsets.symmetric(
              //                     vertical: ThemeConfig().defaultSpacing),
              //                 decoration: InputDecoration(
              //                     border: const OutlineInputBorder(
              //                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //                     ),
              //                     contentPadding: EdgeInsets.symmetric(
              //                         horizontal: ThemeConfig().defaultSpacing)),
              //                 value: restaurantMenuController.lsDescription[index]![0].value,
              //                 onChanged: (String? newValue) {
              //                   // controller.userPreference[index] = newValue!;
              //                 },
              //                 items: restaurantMenuController.lsDescription[index]),
              //           ),
              //         ],
              //       );
              //     }),
              FormInputTextMandatory(
                title: 'Balance',
                txtcontroller: controller.balance,
                textInputType: TextInputType.text,
                txtLine: 2,
                txtEnable: true,
                txtReadonly: true,
                mandatory: false,
                borderColors: Colors.black,
                pLeft: ThemeConfig().defaultSpacing,
                pTop: ThemeConfig().extraSpacing,
                pRight: ThemeConfig().defaultSpacing,
                pBottom: ThemeConfig().defaultSpacing,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.onSaveUserProfile(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeConfig.justGrey),
                      child: Text('SAVE', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () async => await DialogConfig().onLogoutDialog(title: 'LOGOUT', content: 'Yakin ingin logout?'),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: ThemeConfig().defaultSpacing),
                          backgroundColor: ThemeConfig.justGrey,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                      child: Text('Logout', style: ThemeConfig().textHeader4(color: ThemeConfig.justBlack))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopUpContainer extends GetView<EmployeeProfileController> {
  const TopUpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeConfig.justWhite,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Wrap(
        children: [
          FormInputTextMandatory(
            title: 'Amount',
            txtcontroller: controller.amount,
            textInputType: TextInputType.number,
            txtLine: 2,
            txtEnable: true,
            txtReadonly: false,
            mandatory: false,
            borderColors: Colors.black,
            pLeft: ThemeConfig().defaultSpacing,
            pTop: ThemeConfig().extraSpacing,
            pRight: ThemeConfig().defaultSpacing,
            pBottom: ThemeConfig().defaultSpacing,
          ),
        ],
      ),
      actions: [
        Wrap(
          children: [
            ElevatedButton(
                onPressed: () => controller.onTopUpWallet(),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(ThemeConfig().minSpacing)),
                    ),
                    padding: EdgeInsets.zero,
                    backgroundColor: ThemeConfig.justGrey
                ),
                child: const Text(
                  'SEND',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        )
      ],
    );
  }
}

