import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/modules/login/Pages/login_body.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(AssetsConfig.backgroundApp2),
          //         fit: BoxFit.cover)),
          child: Column(
            children: [
              const Spacer(),
              Container(
                constraints: BoxConstraints(
                  minHeight: Get.size.height * .7,
                  maxHeight: Get.size.height * .7,
                ),
                width: Get.size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: const LoginBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
