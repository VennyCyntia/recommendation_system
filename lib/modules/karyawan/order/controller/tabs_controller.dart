import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsController extends GetxController with GetSingleTickerProviderStateMixin{
  TabController? controller;

  final List<Tab> tabs = <Tab>[
    Tab(text: 'Not Paid'),
    Tab(text: 'Process'),
    Tab(text: 'Done'),
  ];

  @override
  void onInit(){
    super.onInit();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose(){
    controller!.dispose();
    super.onClose();
  }


}