// VIEW ADMIN
class ViewRestaurant {
  int? restaurant_id;
  String? username;
  String? restaurant_name;
  String? email;
  String? no_telp;
  String? password;
  String? restaurant_description;
  String? restaurant_image;

  ViewRestaurant({this.restaurant_id, this.username, this.restaurant_name, this.email, this.no_telp, this.password, this.restaurant_description, this.restaurant_image});

  ViewRestaurant.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    username = json['username'];
    restaurant_name = json['restaurant_name'];
    email = json['email'];
    no_telp = json['no_telp'];
    password = json['password'];
    restaurant_description = json['restaurant_description'];
    restaurant_image = json['restaurant_image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurant_id': restaurant_id,
      'username': username,
      'restaurant_name': restaurant_name,
      'email': email,
      'no_telp': no_telp,
      'password': password,
      'restaurant_description': restaurant_description,
      'restaurant_image': restaurant_image,
    };
  }

  ViewRestaurant.fromMap(Map<String, dynamic> map) {
    restaurant_id = map['restaurant_id'];
    username = map['username'];
    restaurant_name = map['restaurant_name'];
    email = map['email'];
    no_telp = map['no_telp'];
    password = map['password'];
    restaurant_description = map['restaurant_description'];
    restaurant_image = map['restaurant_image'];
  }
}

class ViewEmployee {
  int? user_id;
  String? username;
  String? email;
  String? no_telp;
  String? password;
  String? role;

  ViewEmployee({this.user_id, this.username, this.email, this.no_telp, this.password, this.role});

  ViewEmployee.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    username = json['username'];
    email = json['email'];
    no_telp = json['no_telp'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'username': username,
      'email': email,
      'no_telp': no_telp,
      'password': password,
      'role': role,
    };
  }

  ViewEmployee.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    username = map['username'];
    email = map['email'];
    no_telp = map['no_telp'];
    password = map['password'];
    role = map['role'];
  }
}