import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/controller/restaurant_menu_controller.dart';

class TextFieldInputComponent extends StatelessWidget {
  final String title;
  final TextInputType keyboardType;
  TextEditingController? txtController;

  TextFieldInputComponent(
      {Key? key,
        this.txtController,
        required this.title,
        required this.keyboardType})
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
          controller: txtController,
          keyboardType: keyboardType,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              filled: true,
              fillColor: ThemeConfig.justWhite),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Mohon mengisi semua field dengan benar';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class FormInputTextMandatory extends StatelessWidget {
  final String title;
  final String? validatorMsg;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormat;
  final Color borderColors;
  final int txtLine;
  final bool txtEnable;
  final bool txtReadonly;
  final TextInputType textInputType;
  final TextEditingController txtcontroller;

  // final double? pTop;
  // final double? pBottom;
  // final double? pLeft;
  // final double? pRight;
  final bool mandatory;

  const FormInputTextMandatory({
    Key? key,
    required this.title,
    required this.txtcontroller,
    required this.textInputType,
    required this.txtLine,
    required this.txtEnable,
    required this.txtReadonly,
    required this.mandatory,
    this.validatorMsg,
    this.maxLength,
    this.inputFormat,
    required this.borderColors,
    // this.pTop,
    // this.pBottom,
    // this.pLeft,
    // this.pRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ThemeConfig().defaultSpacing,
      ),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: title,
                  style: ThemeConfig().textHeader4Thin(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: mandatory ? '*' : '',
                        style: const TextStyle(color: Colors.red)),
                  ],
                ),
              )),
          TextFormField(
            keyboardType: textInputType,
            controller: txtcontroller,
            maxLines: null,
            minLines: 1,
            inputFormatters: inputFormat ?? [],
            maxLength: maxLength,
            enabled: txtEnable,
            readOnly: txtReadonly,
            validator: (value) {
              if (mandatory && (value == null || value.isEmpty)) {
                return validatorMsg;
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              // hintText: title,
                hintStyle:
                TextStyle(fontSize: 16.0, color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.all(8.0),
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(color: borderColors, width: 2),
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                filled: true,
                fillColor: ThemeConfig.justWhite),
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class FieldDropDown extends GetView<RestaurantMenuController> {
  int? index;
  String type;

  FieldDropDown({super.key, this.index, required this.type});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: ThemeConfig().defaultSpacing,
            mainAxisSpacing: 1.0,
            childAspectRatio: 2.5 / 1),
        itemCount: 4,
        itemBuilder: (context, indexLength) {
          return Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Deskripsi ' + indexLength.toString(),
                      style: ThemeConfig().textHeader4Thin(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style:
                            ThemeConfig().textHeader5(color: Colors.red)),
                      ],
                    ),
                  )),
              Expanded(
                child: DropdownButtonFormField<String>(
                    validator: (String? value) {
                      if (value == '') {
                        return 'Mohon mengisi semua kolom dengan benar';
                      }
                      return null;
                    },
                    padding: EdgeInsets.symmetric(
                        vertical: ThemeConfig().defaultSpacing),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: ThemeConfig().defaultSpacing)),
                    value: type == 'edit' ? controller.selectedDescription[indexLength] : controller.lsDescription[indexLength]![0].value,
                    onChanged: (String? newValue) {
                      controller.onAddDesc(index!, newValue!, indexLength);
                    },
                    items: controller.lsDescription[indexLength]),
              ),
            ],
          );
        });
  }
}

