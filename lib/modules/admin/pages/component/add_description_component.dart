import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/menu_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/component/text_field_input_component.dart';

class AddDescription extends GetView<RestaurantMenuController> {
  const AddDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('Add Deskripsi'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DescriptionComponent(index: 0, title: 'Bahan_utama', txtController: controller.lsAddDescription[0]),
                  DescriptionComponent(index: 1, title: 'Jenis_protein', txtController: controller.lsAddDescription[1]),
                  DescriptionComponent(index: 2, title: 'Jenis_makanan', txtController: controller.lsAddDescription[2]),
                  DescriptionComponent(index: 3, title: 'Rasa', txtController: controller.lsAddDescription[3]),
                ],
              ),
            ),
          )
        ),
    );
  }
}

class DescriptionComponent extends GetView<RestaurantMenuController> {
  int? index;
  String? title;
  TextEditingController? txtController;

  DescriptionComponent({super.key, this.index, this.title, this.txtController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.all(ThemeConfig().biggerSpacing),
      margin: EdgeInsets.only(
          top: ThemeConfig().extra2Spacing),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(
              Radius.circular(10.0))),
      child: Column(
        children: [
          FormInputTextMandatory(
            title: title!,
            textInputType: TextInputType.text,
            mandatory: false,
            txtcontroller: txtController!,
            borderColors: Colors.black,
            txtEnable: true,
            txtLine: 1,
            txtReadonly: false,
          ),
          SizedBox(height: ThemeConfig().defaultSpacing),
          ElevatedButton(
            onPressed: () => controller.onAddDescription(index: index!, desc: txtController!.text, type: title!, txtcontroller: txtController!),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: ThemeConfig().defaultSpacing),
                backgroundColor: Colors.green,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(5.0)))),
            child: Text('Tambah deskripsi',
                style: ThemeConfig()
                    .textHeader5(color: ThemeConfig.justWhite)),
          ),
        ],
      ),
    );
  }
}
