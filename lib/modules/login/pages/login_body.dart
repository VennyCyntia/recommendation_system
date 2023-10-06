import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/Routes/app_routes.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    var isChecked = false.obs;
    return Padding(
      padding: EdgeInsets.all(ThemeConfig().extraSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Login',
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
              onPressed: () => Get.toNamed(AppRoutes.main),
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
              Checkbox(value: isChecked.value, onChanged:(bool? value){
                isChecked.value = value!;
              }),
              const Text('Login as restaurant')
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class FormUsername extends StatelessWidget {
  const FormUsername({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 2.0
          ),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: 'Username',
                  style: ThemeConfig().textHeader4Thin(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(text: '*', style: ThemeConfig().textHeader5(color: Colors.red)
                    ),
                  ],
                ),
              )
          ),
        ),
        TextFormField(
          // controller: Get.find<SignInController>().username,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  ThemeConfig().defaultSpacing
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  ThemeConfig().defaultSpacing
              ),
              borderSide: const BorderSide(
                color: ThemeConfig.justGrey,
              ),
            ),
            contentPadding: const EdgeInsets.all(18.0),
            suffixIcon: const Icon(
              Icons.people_rounded,
            ),
          ),
          // validator: (String? value){
          //   return value == null || value.isEmpty ?
          //   Get.find<SignInController>().languageManager.validateLoginUsername.value : null;
          // },
        ),
      ],
    );
  }
}

class FormPassword extends StatelessWidget {
  const FormPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 2.0
          ),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: 'Password',
                  style: ThemeConfig().textHeader4Thin(color: Colors.grey),
                  children: <TextSpan>[
                    TextSpan(text: '*', style: ThemeConfig().textHeader5(color: Colors.red)
                    ),
                  ],
                ),
              )
          ),
        ),
         TextFormField(
          // controller: Get.find<SignInController>().password,
          textInputAction: TextInputAction.next,
          // obscureText: Get.find<SignInController>().isHidePassword.value,
          decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  ThemeConfig().defaultSpacing
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  ThemeConfig().defaultSpacing
              ),
              borderSide: const BorderSide(
                color: ThemeConfig.justGrey,
              ),
            ),
            contentPadding: const EdgeInsets.all(18.0),
            suffixIcon: GestureDetector(
              onTap: (){
                ThemeConfig().onUnfocuseNode();
                // Get.find<SignInController>().onTogglePassVisibility();
              },
              child:
              Icon(Icons.visibility, color: Colors.grey
                // Get.find<SignInController>().isHidePassword.value
                //     ? Icons.visibility_off
                //     : Icons.visibility,

                // Get.find<SignInController>().isHidePassword.value
                //     ? Colors.grey
                //     : ThemeConfig.justGrey,
              ),
            ),
          ),
          // validator: (String? value){
          //   return value == null || value.isEmpty ?
          //   Get.find<SignInController>().languageManager.validateLoginPassword.value : null;
          // },
        ),
      ],
    );
  }
}