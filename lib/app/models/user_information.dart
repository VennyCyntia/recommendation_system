class UserInformation {
  int? user_id;
  String? username;
  String? email;
  String? no_telp;
  String? role;
  String? preference;
  String? wallet_id;

  UserInformation(
      {this.user_id, this.username, this.email, this.no_telp, this.role, this.preference, this.wallet_id});

  UserInformation.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    username = json['username'];
    email = json['email'];
    no_telp = json['no_telp'];
    role = json['role'];
    preference = json['preference'];
    wallet_id = json['wallet_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'username': username,
      'email': email,
      'no_telp': no_telp,
      'role': role,
      'preference': preference,
      'wallet_id': wallet_id,
    };
  }

  UserInformation.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    username = map['username'];
    email = map['email'];
    no_telp = map['no_telp'];
    role = map['role'];
    preference = map['preference'];
    wallet_id = map['wallet_id'];
  }
}

class RestaurantInformation {
  int? restaurant_id;
  String? restaurant_name;
  String? email;
  String? no_telp;
  String? wallet_id;

  RestaurantInformation(
      {this.restaurant_id, this.restaurant_name, this.email, this.no_telp, this.wallet_id});

  RestaurantInformation.fromJson(Map<String, dynamic> json) {
    restaurant_id = json['restaurant_id'];
    restaurant_name = json['restaurant_name'];
    email = json['email'];
    no_telp = json['no_telp'];
    wallet_id = json['wallet_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'restaurant_id': restaurant_id,
      'restaurant_name': restaurant_name,
      'email': email,
      'no_telp': no_telp,
      'wallet_id': wallet_id,
    };
  }

  RestaurantInformation.fromMap(Map<String, dynamic> map) {
    restaurant_name = map['restaurant_name'];
    email = map['email'];
    no_telp = map['no_telp'];
    wallet_id = map['wallet_id'];
  }

}