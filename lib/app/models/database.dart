// class Restaurant{
//   String? restaurantId;
//   String? userId;
//   String? restaurantName;
//   String? restaurantDescription;
//   String? restaurantImage;
// }

// class Restaurant{
// int? restaurantId;
// String? restaurantName;
// String? restaurantDescription;
// String? restaurantImage;
//
//   Restaurant({this.restaurantId, this.restaurantName, this.restaurantDescription, this.restaurantImage});
//
//   Restaurant.fromJson(Map<String, dynamic> json) {
//     restaurantId = json['restaurantId'];
//     restaurantName = json['restaurantName'];
//     restaurantDescription = json['restaurantDescription'];
//     restaurantImage = json['restaurantImage'];
//   }
// }

// class Menu{
// int? restaurantId;
// int? menuId;
// String? MenuName;
// String? MenuCategory;
// String? MenuDescription;
// int? MenuPrice;
// String? MenuImage;
//
//   Menu({this.restaurantId, this.menuId, this.MenuName, this.MenuCategory, this.MenuDescription, this.MenuPrice, this,MenuImage});
//
//   Menu.fromJson(Map<String, dynamic> json) {
//     restaurantId = json['restaurantId'];
//     menuId = json['userId'];
//     MenuCategory = json['MenuCategory'];
//     MenuDescription = json['MenuDescription'];
//     MenuPrice = json['MenuPrice'];
//     MenuImage = json['MenuImage'];
//   }
// }

// class User{
// int? userId;
// String? username;
// String? email;
// String? noTelepon;
// String? password;
// String? role;
//
//   User({this.userId, this.username, this.email, this.noTelepon, this.password, this.role});
//
//   User.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     username = json['username'];
//     email = json['email'];
//     noTelepon = json['noTelepon'];
//     password = json['password'];
//     role = json['role'];
//   }
// }

// class DetailCart{
// String? userId;
// String? menuId;
// String? menuName;
// String? quantity;
// int? totalPrice;
//
//   DetailCart({this.userId, this.restaurantId, this.menuId, this.quantity});
//
//   DetailCart.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     username = json['username'];
//     email = json['email'];
//     noTelepon = json['noTelepon'];
//     password = json['password'];
//     role = json['role'];
//   }
// }

// class Cart{
// String? userId;
// String? restaurantId;
// String? totalPrice;
// String? quantity;
//
//   Cart({this.userId, this.restaurantId, this.totalPrice, this.quantity});
//
//   Cart.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     restaurantId = json['restaurantId'];
//     totalPrice = json['totalPrice'];
//     quantity = json['quantity'];
//   }
// }

// class RatingMenu{
// String? userId;
// String? menuId;
// String? rate;
//
//   RatingMenu({this.userId, this.menuId, this.rate});
//
//   RatingMenu.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     menuId = json['menuId'];
//     rate = json['rate'];
//   }
// }

// class Order{
// String? orderId;
// String? userId;
// String? restaurantId;
// String? totalPrice;
// String? status;
//
//   Order({this.orderId, this.userId, this.restaurantId, this.totalPrice, this.status});
//
//   Order.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     menuId = json['menuId'];
//     restaurantId = json['restaurantId'];
//     totalPrice = json['totalPrice'];
//     status = json['status'];
//   }
// }

// class DetailOrder{
// String? orderId;
// String? menuId;
// String? quantity;
// String? notes;
//
//   DetailOrder({this.orderId, this.menuId, this.quantity, this.notes});
//
//   DetailOrder.fromJson(Map<String, dynamic> json) {
//     orderId = json['orderId'];
//     menuId = json['menuId'];
//     quantity = json['quantity'];
//     notes = json['notes'];
//   }
// }

// class PreferenceUser{
// int? userId;
// String? preference;
//
//   Order({this.userId, this.preference});
//
//   Order.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     preference = json['preference'];
//   }
// }