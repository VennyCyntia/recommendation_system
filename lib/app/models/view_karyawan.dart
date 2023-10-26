//VIEW
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
  int? menu_id;
  String? menu_category;
  List<ViewItemMenu>? item_menu;

  ViewMenu({this.menu_id, this.menu_category, this.item_menu});

  ViewMenu.fromJson(Map<String, dynamic> json) {
    menu_id = json['menu_id'];
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
  String? menu_image;
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
  int? restaurantid;
  String? restaurantName;
  List<ItemCartMenu>? menu;
  int? totalPrice;

  ItemCartRestaurant({this.id, this.restaurantid, this.restaurantName, this.menu, this.totalPrice});

  ItemCartRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantid = json['restaurantid'];
    restaurantName = json['restaurantName'];
    if (json['menu'] != null) {
      menu = <ItemCartMenu>[];
      json['menu'].forEach((v) {
        menu!.add(ItemCartMenu.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
  }
}

class ItemCartMenu{
  String? menu_image;
  String? menu_name;
  String? menu_subtitle;
  int? menu_price;
  int? total_price;
  int? menu_qty;

  ItemCartMenu({this.menu_image, this.menu_name, this.menu_subtitle, this.menu_price, this.total_price, this.menu_qty});

  ItemCartMenu.fromJson(Map<String, dynamic> json) {
    menu_image = json['menu_image'];
    menu_name = json['menu_name'];
    menu_subtitle = json['menu_subtitle'];
    menu_price = json['menu_price'];
    total_price = json['total_price'];
    menu_qty = json['menu_qty'];
  }
}

class ViewRestaurant {
  int? restaurant_id;
  String? restaurant_name;
  String? restaurant_description;
  String? restaurant_image;

  ViewRestaurant({this.restaurant_id, this.restaurant_name, this.restaurant_description, this.restaurant_image});

  ViewRestaurant.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    restaurant_name = json['restaurant_name'];;
    restaurant_description = json['restaurant_description'];
    restaurant_image = json['restaurant_image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurant_id': restaurant_id,
      'restaurant_name': restaurant_name,
      'restaurant_description': restaurant_description,
      'restaurant_image': restaurant_image,
    };
  }

  ViewRestaurant.fromMap(Map<String, dynamic> map) {
    restaurant_id = map['restaurant_id'];
    restaurant_name = map['restaurant_name'];
    restaurant_description = map['restaurant_description'];
    restaurant_image = map['restaurant_image'];
  }
}