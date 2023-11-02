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
  String? wallet_id;

  ViewRestaurant({this.restaurant_id, this.username, this.restaurant_name, this.email, this.no_telp, this.password, this.restaurant_description, this.restaurant_image, this.wallet_id});

  ViewRestaurant.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    username = json['username'];
    restaurant_name = json['restaurant_name'];
    email = json['email'];
    no_telp = json['no_telp'];
    password = json['password'];
    restaurant_description = json['restaurant_description'];
    restaurant_image = json['restaurant_image'];
    wallet_id = json['wallet_id'];
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
      'wallet_id': wallet_id,
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
    wallet_id = map['wallet_id'];
  }
}

class ViewEmployee {
  int? user_id;
  String? username;
  String? email;
  String? no_telp;
  String? password;
  String? role;
  String? wallet_id;

  ViewEmployee({this.user_id, this.username, this.email, this.no_telp, this.password, this.role, this.wallet_id});

  ViewEmployee.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    username = json['username'];
    email = json['email'];
    no_telp = json['no_telp'];
    password = json['password'];
    role = json['role'];
    wallet_id = json['wallet_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'username': username,
      'email': email,
      'no_telp': no_telp,
      'password': password,
      'role': role,
      'wallet_id': wallet_id,
    };
  }

  ViewEmployee.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    username = map['username'];
    email = map['email'];
    no_telp = map['no_telp'];
    password = map['password'];
    role = map['role'];
    wallet_id = map['wallet_id'];
  }
}