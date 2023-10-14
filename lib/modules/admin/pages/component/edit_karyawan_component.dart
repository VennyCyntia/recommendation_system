import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/text_field_input_component.dart';

class EditKaryawanComponent extends StatelessWidget {
  const EditKaryawanComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit karyawan'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: ThemeConfig().defaultSpacing),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                      margin: EdgeInsets.only(top: ThemeConfig().biggerSpacing),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextFieldInputComponent(
                              title: 'Nama', keyboardType: TextInputType.text),
                          SizedBox(height: ThemeConfig().defaultSpacing),
                          const TextFieldInputComponent(
                              title: 'Email',
                              keyboardType: TextInputType.text),
                          SizedBox(width: ThemeConfig().biggerSpacing),
                          const TextFieldInputComponent(
                              title: 'No Telepon',
                              keyboardType: TextInputType.number),
                          SizedBox(height: ThemeConfig().biggerSpacing),
                          const TextFieldInputComponent(
                              title: 'Password',
                              keyboardType: TextInputType.visiblePassword),
                          SizedBox(height: ThemeConfig().biggerSpacing),
                          const TextFieldInputComponent(
                              title: 'Role',
                              keyboardType: TextInputType.visiblePassword),
                          SizedBox(height: ThemeConfig().biggerSpacing),

                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: ThemeConfig().defaultSpacing),
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)))),
                    child: Text('SAVE', style: ThemeConfig().textHeader5(color: ThemeConfig.justWhite)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
