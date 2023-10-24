import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/karyawan/order/pages/components/form_field_component.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/profile_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/component/text_field_input_component.dart';

class ProfileContainer extends GetView<ProfileController> {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
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
                txtReadonly: false,
                mandatory: false,
                borderColors: Colors.black,
                pLeft: ThemeConfig().defaultSpacing,
                pTop: ThemeConfig().extraSpacing,
                pRight: ThemeConfig().defaultSpacing,
                pBottom: ThemeConfig().defaultSpacing,
              ),
              FormInputTextMandatory(
                title: 'Preferensi',
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){},
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
                      onPressed: (){},
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
