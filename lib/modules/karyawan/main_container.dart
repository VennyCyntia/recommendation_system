import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/home_container.dart';
import 'package:recommendation_system/modules/login/controller/login_controller.dart';

class MainContainer extends GetView<LoginController> {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: const HomeContainer(),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.red,
            showUnselectedLabels: true,
            onTap: controller.selectedItems,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  label: 'Order'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: 'Cart'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile'
              ),
            ],
          ),
        )
    );
  }
}
