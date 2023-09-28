import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recommendation_system/app/config/theme_config.dart';
import 'package:recommendation_system/modules/home/components/menu_component.dart';
import 'package:recommendation_system/modules/home/components/restaurant_component.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Find Your Restaurant',
                      prefixIcon: Icon(Icons.search_rounded),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text('Recommended For You', style: ThemeConfig().textHeader3Bold(color: ThemeConfig.justBlack)),
              const SizedBox(height: 8.0),
              SizedBox(
                height: Get.size.height * .22,
                child: ListView.builder(
                  reverse: false,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MenuComponent(index: index);
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Text('Restaurant', style: ThemeConfig().textHeader3Bold(color: ThemeConfig.justBlack)),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return RestaurantComponent(index: index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
