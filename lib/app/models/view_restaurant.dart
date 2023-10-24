class ViewMenu {
  int? menu_id;
  String? menu_name;
  String? menu_subtitle;
  String? menu_category;
  String? menu_description;
  int? menu_price;
  String? menu_image;
  int? restaurant_id;

  ViewMenu({this.menu_id, this.menu_name, this.menu_subtitle, this.menu_category, this.menu_description, this.menu_price, this.menu_image, this.restaurant_id});

  ViewMenu.fromJson(Map<String, dynamic> json) {
    menu_id = json['menu_id'];
    menu_name = json['menu_name'];
    menu_subtitle = json['menu_subtitle'];
    menu_category = json['menu_category'];
    menu_description = json['menu_description'];
    menu_price = json['menu_price'];
    menu_image = json['menu_image'];
    restaurant_id = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_id': menu_id,
      'menu_name': menu_name,
      'menu_subtitle': menu_subtitle,
      'menu_category': menu_category,
      'menu_description': menu_description,
      'menu_price': menu_price,
      'menu_image': menu_image,
      'restaurant_id': restaurant_id,
    };
  }

  ViewMenu.fromMap(Map<String, dynamic> map) {
    menu_id = map['menu_id'];
    menu_name = map['menu_name'];
    menu_subtitle = map['menu_subtitle'];
    menu_category = map['menu_category'];
    menu_description = map['menu_description'];
    menu_price = map['menu_price'];
    menu_image = map['menu_image'];
    restaurant_id = map['restaurant_id'];
  }
}