//VIEW

import 'dart:typed_data';

class ViewRestaurant {
  int? restaurant_id;
  String? restaurant_name;
  String? restaurant_description;
  String? restaurant_image;
  String? wallet_id;

  ViewRestaurant({this.restaurant_id, this.restaurant_name, this.restaurant_description, this.restaurant_image, this.wallet_id});

  ViewRestaurant.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    restaurant_name = json['restaurant_name'];;
    restaurant_description = json['restaurant_description'];
    restaurant_image = json['restaurant_image'];
    wallet_id = json['wallet_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurant_id': restaurant_id,
      'restaurant_name': restaurant_name,
      'restaurant_description': restaurant_description,
      'restaurant_image': restaurant_image,
      'wallet_id': wallet_id,
    };
  }

  ViewRestaurant.fromMap(Map<String, dynamic> map) {
    restaurant_id = map['restaurant_id'];
    restaurant_name = map['restaurant_name'];
    restaurant_description = map['restaurant_description'];
    restaurant_image = map['restaurant_image'];
    wallet_id = map['wallet_id'];
  }
}

class ViewDetailRestaurant {
  int? restaurant_id;
  String? restaurant_name;
  String? restaurant_description;
  String? restaurant_image;
  List<ViewMenu>? menu;

  ViewDetailRestaurant({this.restaurant_id, this.restaurant_image, this.restaurant_name, this.restaurant_description, this.menu});

  ViewDetailRestaurant.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    restaurant_image = json['restaurant_image'];
    restaurant_name = json['restaurant_name'];
    restaurant_description = json['restaurant_description'];
    menu = <ViewMenu>[];
    json['menu'].forEach((v) {
      menu!.add(ViewMenu.fromJson(v));
    });
  }
}

class ViewMenu {
  int? id;
  String? menu_category;
  List<ViewItemMenu>? item_menu;

  ViewMenu({this.id, this.menu_category, this.item_menu});

  ViewMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menu_category = json['menu_category'];
    if (json['item_menu'] != null) {
      item_menu = <ViewItemMenu>[];
      json['item_menu'].forEach((v) {
        item_menu!.add(ViewItemMenu.fromJson(v));
      });
    }
  }
}

class ViewItemMenu {
  int? menu_id;
  Uint8List? menu_image;
  String? menu_name;
  String? menu_subtitle;
  int? menu_price;
  int? menu_qty;

  ViewItemMenu({this.menu_id, this.menu_image, this.menu_name, this.menu_subtitle, this.menu_price, this.menu_qty});

  ViewItemMenu.fromJson(Map<String, dynamic> json) {
    menu_id = json['menu_id'];
    menu_image = json['menu_image'];
    menu_name = json['menu_name'];
    menu_subtitle = json['menu_subtitle'];
    menu_price = json['menu_price'];
    menu_qty = json['menu_qty'];
  }

  Map<String, dynamic> toMap() => {
    'menu_id': menu_id,
    'menu_image': menu_image,
    'menu_name': menu_name,
    'menu_subtitle': menu_subtitle,
    'menu_price': menu_price,
    'menu_qty': menu_qty,
  };
}

class ItemCartRestaurant{
  int? id;
  int? restaurant_id;
  String? wallet_id;
  String? restaurant_name;
  List<ItemCartMenu>? menu;

  ItemCartRestaurant({this.id, this.restaurant_id, this.wallet_id, this.restaurant_name, this.menu});

  ItemCartRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    restaurant_id = json['restaurant_id'];
    wallet_id = json['wallet_id'];
    restaurant_name = json['restaurant_name'];
    if (json['menu'] != null) {
      menu = <ItemCartMenu>[];
      json['menu'].forEach((v) {
        menu!.add(ItemCartMenu.fromJson(v));
      });
    }
  }
}

class ItemCartMenu{
  int? menu_id;
  String? menu_image;
  String? menu_name;
  String? menu_subtitle;
  int? menu_price;
  int? total_price;
  int? menu_qty;
  bool? checkbox;

  ItemCartMenu({this.menu_id, this.menu_image, this.menu_name, this.menu_subtitle, this.menu_price, this.total_price, this.menu_qty, this.checkbox});

  ItemCartMenu.fromJson(Map<String, dynamic> json) {
    menu_id = json['menu_id'];
    menu_image = json['menu_image'];
    menu_name = json['menu_name'];
    menu_subtitle = json['menu_subtitle'];
    menu_price = json['menu_price'];
    total_price = json['total_price'];
    menu_qty = json['menu_qty'];
    checkbox = false;
  }

  Map<String, dynamic> toJson() => {
    'menu_id': menu_id,
    'menu_name': menu_name,
    'menu_subtitle': menu_subtitle,
    'menu_price': menu_price,
    'total_price': total_price,
    'menu_qty': menu_qty,
    'checkbox': checkbox
  };
}

class Order{
  int? user_id;
  String? order_id;
  int? queue_number;
  String? restaurant_name;
  String? wallet_id;
  int? total_price;
  String? status;
  List<OrderItem>? menu;

  Order({this.user_id, this.order_id, this.queue_number, this.restaurant_name, this.wallet_id, this.total_price, this.menu, this.status});

  Order.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    order_id = json['order_id'];
    queue_number = json['queue_number'];
    restaurant_name = json['restaurant_name'];
    wallet_id = json['wallet_id'];
    total_price = json['total_price'];
    status = json['status'];
    if (json['menu'] != null) {
      menu = <OrderItem>[];
      json['menu'].forEach((v) {
        menu!.add(OrderItem.fromJson(v));
      });
    }
  }
}

class RestaurantOrder{
  int? restaurant_id;
  String? order_id;
  int? queue_number;
  String? username;
  int? total_price;
  String? status;
  List<OrderItem>? menu;

  RestaurantOrder({this.restaurant_id, this.order_id, this.queue_number, this.username, this.total_price, this.menu, this.status});

  RestaurantOrder.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    order_id = json['order_id'];
    queue_number = json['queue_number'];
    username = json['username'];
    total_price = json['total_price'];
    status = json['status'];
    if (json['menu'] != null) {
      menu = <OrderItem>[];
      json['menu'].forEach((v) {
        menu!.add(OrderItem.fromJson(v));
      });
    }
  }
}

class OrderItem{
  int? menu_id;
  String? menu_name;
  int? menu_price;
  int? menu_qty;

  OrderItem({this.menu_id, this.menu_name, this.menu_price, this.menu_qty});

  OrderItem.fromJson(Map<String, dynamic> json) {
    menu_id = json['menu_id'];
    menu_name = json['menu_name'];
    menu_price = json['menu_price'];
    menu_qty = json['menu_qty'];
  }

  Map<String, dynamic> toJson() => {
    'menu_id': menu_id,
    'menu_name': menu_name,
    'menu_price': menu_price,
    'menu_qty': menu_qty,
  };
}