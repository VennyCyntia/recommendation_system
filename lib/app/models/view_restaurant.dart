class ViewMenu {
  int? id;
  String? title;
  String? subtitle;
  String? category;
  String? description;
  int? price;
  String? pic;

  ViewMenu({this.id, this.title, this.subtitle, this.category, this.description, this.price, this.pic});

  ViewMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    category = json['category'];
    description = json['description'];
    price = json['price'];
    pic = json['pic'];
  }

  ViewMenu.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    subtitle = map['subtitle'];
    category = map['category'];
    description = map['description'];
    price = map['price'];
    pic = map['pic'];
  }
}