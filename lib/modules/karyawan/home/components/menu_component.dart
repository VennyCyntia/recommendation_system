import 'package:flutter/material.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';


class MenuComponent extends StatelessWidget {
  int? index;
  MenuComponent({super.key, this.index});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: (){
                // Get.to(() => MenuContainer(index: index))
              },
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      )],
                      border: Border.all(color: Colors.grey.shade400, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ThemeConfig().minSpacing)),
                  child: Column(
                    children: [
                      Image.network('https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg', height: Get.size.height * .15),
                      Text('Nasi Goreng'),
                      Text('Rp 30.000')
                    ],
                  )
              ),
            )
        ),
      ],
    );
  }
}
