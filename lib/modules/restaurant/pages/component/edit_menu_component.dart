import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/restaurant/pages/component/text_field_input_component.dart';

class EditMenuComponent extends StatelessWidget {
  const EditMenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Menu'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(ThemeConfig().defaultSpacing),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                      vertical: ThemeConfig().defaultSpacing),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(ThemeConfig().biggerSpacing),
                      margin: EdgeInsets.only(top: ThemeConfig().biggerSpacing),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextFieldInputComponent(
                              title: 'Title', keyboardType: TextInputType.text),
                          SizedBox(height: ThemeConfig().defaultSpacing),
                          const TextFieldInputComponent(
                              title: 'Category',
                              keyboardType: TextInputType.text),
                          SizedBox(width: ThemeConfig().biggerSpacing),
                          const TextFieldInputComponent(
                              title: 'Price',
                              keyboardType: TextInputType.number),
                          SizedBox(height: ThemeConfig().biggerSpacing),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: ThemeConfig().defaultSpacing),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ThemeConfig().defaultSpacing))),
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(40),
                                        // Image radius
                                        child: const Center(
                                            child: Text('No Photo')))),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      minimumSize: const Size.fromHeight(48),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              ThemeConfig().defaultSpacing))),
                                  child: Text('from gallery',
                                      style: ThemeConfig().textHeader5Bold(
                                          color: ThemeConfig.justWhite)),
                                ),
                              ),
                            ],
                          ),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: ThemeConfig().defaultSpacing),
                        backgroundColor: Colors.green,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                    child: Text('SAVE',
                        style: ThemeConfig()
                            .textHeader5(color: ThemeConfig.justWhite)),
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
