import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/modules/restaurant/menu/controller/main_controller.dart';
import 'package:recommendation_system/modules/restaurant/menu/pages/menu_restaurant_container.dart';

class RestaurantMainContainer extends GetView<RestaurantController> {
  const RestaurantMainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: const MenuRestaurantContainer(),
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
                  icon: Icon(Icons.restaurant_menu),
                  label: 'Menu'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  label: 'Order'
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
