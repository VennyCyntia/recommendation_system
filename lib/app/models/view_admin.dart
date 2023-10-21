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