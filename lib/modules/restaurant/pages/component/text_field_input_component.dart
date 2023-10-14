import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';

class TextFieldInputComponent extends StatelessWidget {
  final String title;
  final TextInputType keyboardType;

  const TextFieldInputComponent(
      {Key? key, required this.title, required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: title,
                  style: ThemeConfig().textHeader4Thin(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: '*',
                        style: ThemeConfig().textHeader5(color: Colors.red)),
                  ],
                ),
              )),
        ),
        TextFormField(
          keyboardType: keyboardType,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              filled: true,
              fillColor: ThemeConfig.justWhite),
        ),
      ],
    );
  }
}
