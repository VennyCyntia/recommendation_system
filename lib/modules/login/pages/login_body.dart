import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/routes/app_routes.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/login/controller/login_controller.dart';

class LoginBody extends GetView<LoginController> {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(ThemeConfig().extraSpacing),
        child: Form(
          key: controller.formLoginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('LOGIN',
                style: ThemeConfig().textExtraBold(color: Colors.black),
              ),
              const SizedBox(height: 22.0),
              const FormUsername(),
              const SizedBox(height: 12.0),
              const FormPassword(),
              const SizedBox(height: 36.0),
              SizedBox(
                height: ThemeConfig().defaultFormHeight,
                width: Get.size.width * 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ThemeConfig.justGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ThemeConfig().extraSpacing
                        ),
                      ),
                      elevation: 0
                  ),
                  onPressed: () => controller.onValidateUser(),
                  child: Text('Login',
                    style: ThemeConfig().textHeader3(
                      color: ThemeConfig.justWhite,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36.0),
              SizedBox(
                height: ThemeConfig().defaultFormHeight,
                width: Get.size.width * 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ThemeConfig.justGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ThemeConfig().extraSpacing
                        ),
                      ),
                      elevation: 0
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.employeeMain),
                  child: Text('Login Karyawan',
                    style: ThemeConfig().textHeader3(
                      color: ThemeConfig.justWhite,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                height: ThemeConfig().defaultFormHeight,
                width: Get.size.width * 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ThemeConfig.justGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ThemeConfig().extraSpacing
                        ),
                      ),
                      elevation: 0
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.restaurant),
                  child: Text('Login Restaurant',
                    style: ThemeConfig().textHeader3(
                      color: ThemeConfig.justWhite,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                height: ThemeConfig().defaultFormHeight,
                width: Get.size.width * 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ThemeConfig.justGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            ThemeConfig().extraSpacing
                        ),
                      ),
                      elevation: 0
                  ),
                  onPressed: () => Get.toNamed(AppRoutes.admin),
                  child: Text('Login Admin',
                    style: ThemeConfig().textHeader3(
                      color: ThemeConfig.justWhite,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                      value: controller.isRestaurant.value, checkColor: ThemeConfig.justBlack, onChanged:(bool? value){
                    controller.isRestaurant.value = value!;
                  })),
                  const Text('Login as restaurant')
                ],
              ),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class FormUsername extends GetView<LoginController> {
  const FormUsername({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: 'Username',
                  style: ThemeConfig().textHeader4Thin(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: ThemeConfig().textHeader5(color: Colors.red)),
                  ],
                ),
              )),
        ),
        TextFormField(
          controller: controller.username,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig().defaultSpacing),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig().defaultSpacing),
              borderSide: const BorderSide(
                color: ThemeConfig.justGrey,
              ),
            ),
            contentPadding: const EdgeInsets.all(18.0),
          ),
          validator: (String? value) {
            return value == null || value.isEmpty
                ? 'Username wajib diisi'
                : null;
          },
        ),
      ],
    );
  }
}

class FormPassword extends GetView<LoginController> {
  const FormPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: 'Password',
                  style: ThemeConfig().textHeader4Thin(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: ThemeConfig().textHeader5(color: Colors.red)),
                  ],
                ),
              )),
        ),
        Obx(() => TextFormField(
          controller: controller.password,
          textInputAction: TextInputAction.next,
          obscureText: controller.isHidePassword.value,
          decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig().defaultSpacing),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig().defaultSpacing),
              borderSide: const BorderSide(
                color: ThemeConfig.justGrey,
              ),
            ),
            contentPadding: const EdgeInsets.all(18.0),
            suffixIcon: GestureDetector(
              onTap: () {
                controller.onShowPassVisibility();
              },
              child: Icon(
                controller.isHidePassword.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: controller.isHidePassword.value
                    ? Colors.grey
                    : ThemeConfig.justGrey,
              ),
            ),
          ),
          validator: (String? value){
            return value == null || value.isEmpty ?
            'Password wajib diisi' : null;
          },
        )),
      ],
    );
  }
}

