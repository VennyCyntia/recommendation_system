import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recommendation_system/Routes/app_routes.dart';
import 'package:recommendation_system/app/config/api_config.dart';
import 'package:recommendation_system/app/config/dialog_config.dart';
import 'package:recommendation_system/app/config/global_url.dart';
import 'package:recommendation_system/app/models/view_karyawan.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/menu_container.dart';
import 'package:recommendation_system/modules/karyawan/home/pages/restaurant_page.dart';
import 'package:recommendation_system/modules/karyawan/cart/controller/cart_controller.dart';
import 'package:recommendation_system/modules/karyawan/profile/controller/employee_profile_controller.dart';

class RestaurantController extends GetxController {
  var profileController = Get.put(EmployeeProfileController());
  var cartController = Get.find<CartController>();

  var lsRestaurant = List<ViewRestaurant>.empty(growable: true).obs;

  var foundRestaurant = List<ViewRestaurant>.empty(growable: true).obs;

  var lsRecommendationMenu = List<ViewDetailRestaurant>.empty(growable: true);
  var recommendationMenu = List<Map<String, dynamic>>.empty(growable: true).obs;

  var lsSimilarMenu = List<ViewItemMenu>.empty(growable: true).obs;

  var restaurantDetail = ViewDetailRestaurant().obs;
  var menuDetail = {}.obs;

  var foundMenu = List<ViewMenu>.empty(growable: true).obs;

  var lsPic = List<dynamic>.empty(growable: true).obs;
  var menuDetailPic = List<dynamic>.empty(growable: true).obs;
  var lsRecommendationPic = List<dynamic>.empty(growable: true).obs;
  var lsSimilarItemPic = List<dynamic>.empty(growable: true).obs;

  var userPreference = List<String>.generate(4, (index) => '').obs;

  TextEditingController findRestaurant = TextEditingController();
  TextEditingController findFood = TextEditingController();
  TextEditingController preferenceField = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() async {
    // isLoading.value = true;
    super.onInit();
  }

  Future<void> onSetUpMenu() async {
    isLoading.value = true;
    foundRestaurant.clear();
    lsRestaurant.clear();

    String url = GlobalUrl.baseUrl + GlobalUrl.getAllRestaurant;
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = jsonDecode(result);
    print('result onSetUpMenu'+result);
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {
      isLoading.value = false;
      print('masuk sini');
    }else{
      for(var item in data){
        lsRestaurant.add(ViewRestaurant.fromJson(item));
        foundRestaurant.add(ViewRestaurant.fromJson(item));
      }
      await Future.delayed(const Duration(milliseconds: 2), () async => await onGetRecommendation(user_id: profileController.id.value));
      isLoading.value = false;
    }
  }

  Future<void> onGetRecommendation({required int user_id}) async {
    lsRecommendationMenu.clear();
    recommendationMenu.clear();

    String url = GlobalUrl.baseUrl + GlobalUrl.getRecommendation + user_id.toString();
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    print('result get recoommendation '+result);

    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {
      isLoading.value = false;
      print('masuk sini');
    }else{
      var data = jsonDecode(result);

      for(var item in data){
        for(var menu in item['menu']){
          for(var itemmenu in menu['item_menu']){
            // String getAttachmentUrl = GlobalUrl.baseUrl + GlobalUrl.getAttachment + itemmenu['menu_image'];
            // print(getAttachmentUrl);
            // var image = await APIConfig().getFile(uploadUrl: getAttachmentUrl);
            recommendationMenu.add({
              "restaurant_id": itemmenu['restaurant_id'],
              "menu_id": itemmenu['menu_id'],
              // "menu_image": image,
              "menu_name": itemmenu['menu_name'],
              "menu_price": itemmenu['menu_price']
            });
          }
        }
      }
    }

  }

  Future<void> onGetRestaurantDetail({required int id, required int index}) async {
    isLoading.value = true;
    restaurantDetail.value = ViewDetailRestaurant();
    foundMenu.clear();

    String url = GlobalUrl.baseUrl + GlobalUrl.getAllRestaurantData + id.toString();
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = await jsonDecode(result);

    // print('data ');
    // print(data);
    // print('===============================================================================');

    // var lsImage = [];
    // for(var item in data['menu']){
    //   for(var menu in item['item_menu']){
    //     String getAttachmentUrl = GlobalUrl.baseUrl + GlobalUrl.getAttachment + menu['menu_image'];
    //     print(getAttachmentUrl);
    //     var image = await APIConfig().getFile(uploadUrl: getAttachmentUrl);
    //     lsImage.add(image);
    // }
    // }

    var index = 0;
    restaurantDetail.value = await ViewDetailRestaurant(
      restaurant_id: data['restaurant_id'],
      restaurant_image : data['restaurant_image'],
      restaurant_name : data['restaurant_name'],
      restaurant_description : data['restaurant_description'],
      menu: (data['menu'] as List<dynamic>)
          .map((menu) => ViewMenu(
        menu_category: menu['menu_category'],
        item_menu: (menu['item_menu'] as List<dynamic>)
            .map((itemMenu){
          ViewItemMenu vItemMenu =  ViewItemMenu(
              menu_id: itemMenu['menu_id'],
              menu_name: itemMenu['menu_name'],
              menu_price: itemMenu['menu_price'],
              menu_subtitle: itemMenu['menu_subtitle'],
              menu_qty: itemMenu['menu_qty'],
              // menu_image: lsImage[index]
          );
          index++;
          return vItemMenu;
        }).toList(),
      )).toList(),
    );

    // index = 0;
    for(var item in restaurantDetail.value.menu!){
      List<ViewItemMenu> data = [];
      for(var menu in item.item_menu!){
        data.add(ViewItemMenu(
          menu_id: menu.menu_id,
          menu_name: menu.menu_name,
          menu_price: menu.menu_price,
          menu_subtitle: menu.menu_subtitle,
          menu_qty: menu.menu_qty,
          // menu_image: lsImage[index]
        ));
      }
      foundMenu.add(ViewMenu(
          menu_category: item.menu_category!,
          item_menu: data
      ));
    }

    isLoading.value = false;

    Future.delayed(Duration.zero, () =>
        Get.to(() => RestaurantPage(id: id)));
  }

  Future<void> onGetDetailMenu({required int menu_id}) async {
    menuDetail.clear();

    String url = GlobalUrl.baseUrl + GlobalUrl.getMenuById + menu_id.toString();
    var result = await APIConfig().sendDataToApi(url: url, method: 'GET');
    var data = jsonDecode(result);

    // String getAttachmentUrl = GlobalUrl.baseUrl + GlobalUrl.getAttachment + data['menu_image'];
    // var image = await APIConfig().getFile(uploadUrl: getAttachmentUrl);

    menuDetail.value = {
      'menu_id': data['menu_id'],
      "menu_category": data['menu_category'],
      "menu_description": data['menu_description'],
      "menu_name": data['menu_name'],
      // "menu_image": image,
      "menu_price": data['menu_price'],
      "menu_qty": data['menu_qty'],
      "menu_subtitle": data['menu_subtitle'],
      'restaurant_id': data['restaurant_id']
    };
  }

  Future<void> onToMenuContainer({required int menu_id}) async {
    DialogConfig().onShowLoadingIndicator();
    await onGetDetailMenu(menu_id: menu_id);
    await onGetSimilarItems(menu_id: menu_id);
    await Future.delayed(Duration.zero, () => Get.to(() => const MenuContainer()));
    Get.isDialogOpen == true && Get.isDialogOpen! ? Get.back() : null;
  }

  Future<void> onGetSimilarItems({required int menu_id}) async {
    lsSimilarMenu.clear();
    lsSimilarItemPic.clear();

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.getSimilarItems}$menu_id';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'GET');
    var data = jsonDecode(result);

    for(var item in data){
      // String getAttachmentUrl = GlobalUrl.baseUrl + GlobalUrl.getAttachment + item['menu_image'];
      // print(getAttachmentUrl);
      // var image = await APIConfig().getFile(uploadUrl: getAttachmentUrl);
      lsSimilarMenu.add(ViewItemMenu(
        menu_id : item['menu_id'],
        // menu_image : image,
        menu_name : item['menu_name'],
        menu_subtitle : item['menu_subtitle'],
        menu_price : item['menu_price'],
        menu_qty : item['menu_qty'],
      ));
      // lsSimilarItemPic.add(image);
    }

    for(var item in lsSimilarMenu){
      print('item '+item.menu_name!);
    }
  }

  // onIncreaseItem(
  //     {required int indexItem,
  //       required int indexCategory}) {
  //
  //   ViewItemMenu currentMenu = restaurantDetail.value
  //       .menu![indexCategory].item_menu![indexItem];
  //
  //   currentMenu.menu_qty = currentMenu.menu_qty! + 1;
  //
  //   restaurantDetail.refresh();
  // }

  onIncreaseItem() {

    // ViewItemMenu currentMenu = restaurantDetail.value
    //     .menu![indexCategory].item_menu![indexItem];

    menuDetail['menu_qty'] = menuDetail['menu_qty']! + 1;
    menuDetail.refresh();
  }

  onDecreaseItem() {
    if (menuDetail['menu_qty'] != 0) {
      menuDetail['menu_qty'] = menuDetail['menu_qty'] - 1;
    }
    menuDetail.refresh();
  }


  // onDecreaseItem(
  //     {required int indexItem,
  //       required int indexCategory}) {
  //   ViewItemMenu currentMenu = restaurantDetail.value
  //       .menu![indexCategory]
  //       .item_menu![indexItem];
  //
  //   if (currentMenu.menu_qty != 0) {
  //     currentMenu.menu_qty = currentMenu.menu_qty! - 1;
  //   }
  //
  //   restaurantDetail.refresh();
  // }

  Future<void> onAddMenu (
      {required int menuId}) async {

    // ViewDetailRestaurant? currentRestaurant = restaurantDetail.value;
    // ViewItemMenu currentMenu = restaurantDetail.value
    //     .menu![indexCategory]
    //     .item_menu![indexItem];

    Map body = {
      'user_id' : profileController.id.value,
      'restaurant_id' : menuDetail['restaurant_id'],
      'menu_id' : menuId,
      'quantity' : menuDetail['menu_qty']
    };
    log(json.encode(body));

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.createItem}';
    var result = await APIConfig().onSendOrGetSource(url: url, methodType: 'POST', body: body);
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    }else{
      await cartController.onGetAllData().then((value){
        Future.delayed(const Duration(milliseconds: 2), () => Get.back());
      });
    }
  }

  onFindRestaurant(String type, String value){
    if(type == 'restaurant'){
      List<ViewRestaurant> result = [];
      if(value.isEmpty){
        foundRestaurant.clear();
        foundRestaurant.addAll(lsRestaurant);
      }else{
        result = lsRestaurant.where((restaurant) => restaurant.restaurant_name!.contains(value.toLowerCase())).toList();
        foundRestaurant.clear();
        foundRestaurant.addAll(result);
      }
    }else{
      List<ViewMenu> result = [];
      if(value.isEmpty){
        foundMenu.clear();
        foundMenu.addAll(restaurantDetail.value.menu!);
      }else{
        for (var item in restaurantDetail.value.menu!) {
          var matchingItems = item.item_menu!.where((data) => data.menu_name!.toLowerCase().contains(value)).toList();
          if (matchingItems != []) {

          }
          result.add(ViewMenu(
              menu_category: item.menu_category,
              item_menu: matchingItems
          ));
        }
        foundMenu.clear();
        foundMenu.addAll(result);
      }
    }

  }

  Future<void> onSaveUserPreference() async {
    String combinedDesc = '';

      for (int i = 0; i < userPreference.length; i++) {
        if (i == 0) {
          combinedDesc = (userPreference[i]);
        } else {
          combinedDesc = '${combinedDesc}, ${userPreference[i]}';
        }
      }

      Map body = {
        'user_id': profileController.id.value,
        'preference': combinedDesc
      };
      log(json.encode(body));

    String url = '${GlobalUrl.baseUrl}${GlobalUrl.createPreference}';
    var result = await APIConfig()
        .onSendOrGetSource(url: url, methodType: 'POST', body: body);
    print('result '+result.toString());
    if (result.toLowerCase().contains('failed') ||
        result.toLowerCase().contains('gagal') ||
        result.toLowerCase().contains('error')) {

    }else{
      DialogConfig().onShowLoadingIndicator();
      Get.offNamed(AppRoutes.employeeMain);
      Get.isDialogOpen == true && Get.isDialogOpen! ? Get.back() : null;
      Get.offAllNamed(AppRoutes.employeeMain);
    }
  }

  // var menu = [
  //   {
  //     'pic': "https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg",
  //     'restaurantName': "Noodlelicious",
  //     'menu': [
  //       {
  //         'category': "Noodles",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Premium',
  //             'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Classic',
  //             'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle': 'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //         ]
  //       },
  //       {
  //         'category': "Condiment",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Classic',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           }
  //         ]
  //       },
  //       {
  //         'category': "Drink",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 20000,
  //             'qty': 0,
  //           }
  //         ]
  //       }
  //     ]
  //   },
  //   {
  //     'pic': "https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg",
  //     'restaurantName': "Manggang",
  //     'menu': [
  //       {
  //         'category': "Noodles",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Classic',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //         ]
  //       },
  //       {
  //         'category': "Condiment",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Classic',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           }
  //         ]
  //       },
  //       {
  //         'category': "Drink",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 19000,
  //             'qty': 0,
  //           }
  //         ]
  //       }
  //     ]
  //   },
  //   {
  //     'pic': "https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg",
  //     'restaurantName': "Taichan",
  //     'menu': [
  //       {
  //         'category': "Noodles",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Classic',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //         ]
  //       },
  //       {
  //         'category': "Condiment",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Classic',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           }
  //         ]
  //       },
  //       {
  //         'category': "Drink",
  //         'itemMenu': [
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           },
  //           {
  //             'pic': 'https://imgx.sonora.id/crop/0x0:0x0/360x240/photo/2022/10/22/istockphoto-1345298910-170667aj-20221022110522.jpg',
  //             'title': 'Mie Oven Iga Bakar Premium',
  //             'subtitle':
  //             'Lorem Ipsum is simply dummy text \nof the printing and typesetting industry.',
  //             'price': 18000,
  //             'qty': 0,
  //           }
  //         ]
  //       }
  //     ]
  //   },
  // ].obs;
}