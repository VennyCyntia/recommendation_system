//VIEW
class ViewRestaurant {
  int? restaurant_id;
  String? restaurant_image;
  String? restaurantName;
  List<ViewMenu>? menu;

  ViewRestaurant({this.restaurant_id, this.restaurant_image, this.restaurantName, this.menu});

  ViewRestaurant.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    restaurant_image = json['restaurant_image'];
    restaurantName = json['restaurantName'];
    menu = <ViewMenu>[];
    json['menu'].forEach((v) {
      menu!.add(ViewMenu.fromJson(v));
    });
  }
}

class ViewMenu {
  int? menu_id;
  String? menu_category;
  List<ViewItemMenu>? itemMenu;

  ViewMenu({this.menu_id, this.menu_category, this.itemMenu});

  ViewMenu.fromJson(Map<String, dynamic> json) {
    menu_id = json['menu_id'];
    menu_category = json['menu_category'];
    if (json['itemMenu'] != null) {
      itemMenu = <ViewItemMenu>[];
      json['itemMenu'].forEach((v) {
        itemMenu!.add(ViewItemMenu.fromJson(v));
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

  ViewItemMenu({this.menu_id, this.menu_image, this.menu_name, this.menu_subtitle, this.menu_price, menu_qty});

  ViewItemMenu.fromJson(Map<String, dynamic> json) {
    menu_id = json['menu_id'];
    menu_image = json['menu_image'];
    menu_name = json['menu_name'];
    menu_subtitle = json['subtitle'];
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
  String? restaurantName;
  List<ItemCartMenu>? menu;
  int? totalPrice;

  ItemCartRestaurant({this.id, this.restaurantName, this.menu, this.totalPrice});

  ItemCartRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  String? pic;
  String? title;
  int? price;
  int? totalprice;
  int? orderQty;

  ItemCartMenu({this.pic, this.title, this.price, this.totalprice, this.orderQty});

  ItemCartMenu.fromJson(Map<String, dynamic> json) {
    pic = json['pic'];
    title = json['title'];
    price = json['price'];
    totalprice = json['totalprice'];
    orderQty = json['orderQty'];
  }
}

