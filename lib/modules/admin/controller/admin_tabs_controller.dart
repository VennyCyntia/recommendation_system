
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminTabsController extends GetxController with GetTickerProviderStateMixin{
  TabController? controller;
  TabController? controllerKaryawan;
  TabController? controllerTenant;

  final List<Tab> tabs = <Tab>[
    Tab(text: 'Karyawan'),
    Tab(text: 'Tenant'),
  ];

  final List<Tab> tabsKaryawan = <Tab>[
    Tab(child: Row(children: [
      Text('Add Karyawan'), Icon(Icons.add)
    ],),),
    Tab(child: Row(children: [
      Text('Edit Karyawan'), Icon(Icons.edit)
    ],),),
  ];

  final List<Tab> tabsTenant = <Tab>[
    Tab(child: Row(children: [
      Text('Add Tenant'), Icon(Icons.add)
    ],),),
    Tab(child: Row(children: [
      Text('Edit Tenant'), Icon(Icons.edit)
    ],),),
  ];

  @override
  void onInit(){
    super.onInit();
    controller = TabController(length: tabs.length, vsync: this);
    controllerKaryawan = TabController(length: tabsKaryawan.length, vsync: this);
    controllerTenant = TabController(length: tabsTenant.length, vsync: this);
  }

  @override
  void onClose(){
    controller!.dispose();
    super.onClose();
  }


}