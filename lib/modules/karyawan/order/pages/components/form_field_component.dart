import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class FormFieldComponent extends StatelessWidget {
  String? title;
  TextEditingController? txtController;

  FormFieldComponent({super.key, this.title, this.txtController});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    text: title!,
                    style: ThemeConfig()
                        .textHeader4Thin(color: Colors.black),
                  ),
                )),
          ),
          TextFormField(
            // controller: Get.find<SignInController>().username,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    ThemeConfig().defaultSpacing
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    ThemeConfig().defaultSpacing
                ),
                borderSide: const BorderSide(
                  color: ThemeConfig.justGrey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
