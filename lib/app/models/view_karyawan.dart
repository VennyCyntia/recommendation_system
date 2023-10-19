//VIEW
class ViewRestaurant {
  int? id;
  String? pic;
  String? restaurantName;
  List<ViewMenu>? menu;

  ViewRestaurant({this.id, this.pic, this.restaurantName, this.menu});

  ViewRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
    restaurantName = json['restaurantName'];
    menu = <ViewMenu>[];
    json['menu'].forEach((v) {
      menu!.add(ViewMenu.fromJson(v));
    });
  }
}

class ViewMenu {
  int? id;
  String? category;
  List<ViewItemMenu>? itemMenu;

  ViewMenu({this.id, this.category, this.itemMenu});

  ViewMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    if (json['itemMenu'] != null) {
      itemMenu = <ViewItemMenu>[];
      json['itemMenu'].forEach((v) {
        itemMenu!.add(ViewItemMenu.fromJson(v));
      });
    }
  }
}

class ViewItemMenu {
  int? id;
  String? pic;
  String? title;
  String? subtitle;
  int? price;
  int? qty;

  ViewItemMenu({this.id, this.pic, this.title, this.subtitle, this.price, this.qty});

  ViewItemMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
    title = json['title'];
    subtitle = json['subtitle'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'pic': pic,
    'title': title,
    'subtitle': subtitle,
    'price': price,
    'qty': qty,
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

