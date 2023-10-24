import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? controller;

  final List<Tab> tabsOrder = <Tab>[
    Tab(text: 'Process'),
    Tab(text: 'Done'),
  ];

  @override
  void onInit(){
    super.onInit();
    controller = TabController(length: tabsOrder.length, vsync: this);
  }

  @override
  void onClose(){
    controller!.dispose();
    super.onClose();
  }


}