// VIEW ADMIN
class ViewRestaurant {
  int? id;
  String? restaurantname;
  String? description;

  ViewRestaurant({this.id, this.restaurantname, this.description});

  ViewRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantname = json['restaurantname'];
    description = json['description'];
  }

  ViewRestaurant.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    restaurantname = map['restaurantname'];
    description = map['description'];
  }
}

class ViewEmployee {
  int? id;
  String? employeename;
  String? email;
  String? notelepon;
  String? password;
  String? role;

  ViewEmployee({this.id, this.employeename, this.email, this.notelepon, this.password, this.role});

  ViewEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeename = json['employeename'];
    email = json['email'];
    notelepon = json['notelepon'];
    password = json['password'];
    role = json['role'];
  }

  ViewEmployee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    employeename = map['employeename'];
    email = map['email'];
    notelepon = map['notelepon'];
    password = map['password'];
    role = map['role'];
  }
}