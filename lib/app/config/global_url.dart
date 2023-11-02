class GlobalUrl{
  // static String baseUrl = 'http://10.10.10.125:5000/';
  // static String baseUrl = 'http://192.168.83.184:5000';
  // static String baseUrl = 'http://192.168.1.101:5000';
  // static String baseUrl = 'http://192.168.137.2:5000';
  // static String baseUrl = 'http://192.168.0.165:5000';
  static String baseUrl = 'http://192.168.1.102:5000';

  //Login
  static String loginUser = "/login/employee";
  static String loginRestaurant = "/login/restaurant";

  static String getAllRestaurantData = "/restaurant/menu/"; //pakai id

  // Employee
  static String createEmployee = "/user/create";
  static String updateEmployee = "/user/update/"; // pakai id
  static String getAllEmployee = "/user";
  static String getEmployeeById = "/user/"; // pakai id
  static String deleteEmployee = "/user/delete/"; // pakai id
  static String createPreference = "/user/createpreference";
  // static String createPreference = "/user/createpreference"; // pakai id

  // Restaurant
  static String createRestaurant = "/restaurant/create";
  static String updateRestaurant = "/restaurant/update/"; // pakai id
  static String getAllRestaurant = "/restaurant";
  static String getRestaurantById = "/restaurant/"; // pakai id
  static String deleteRestaurant = "/restaurant/delete/"; // pakai id

  // Menu
  static String createMenu = "/menu/create";
  static String updateMenu = "/menu/update/"; // pakai id
  static String getAllMenu= "/menu";
  static String getMenuById = "/menu/"; // pakai id
  static String getMenuByRestaurant = "/menu/restaurant/"; // pakai id
  static String deleteMenu = "/menu/delete/"; // pakai id

  // Attachment
  static String uploadAttachment = "/attachment/upload";
  static String getAttachment = "/attachment/"; // pakai id

  // Cart
  static String createItem = "/cart/create";
  static String getItem = "/cart/alldata/";
  static String deleteCartItem = "/cart/delete";

  //Order
  static String createOrder = "/order/create";
  static String getOrderById = "/order/getallorder/"; // pakai id
  static String updateOrder = "/order/update"; // pakai id
  static String sendRating = "/order/rating";
  static String getOrderByRestaurant = "/restaurantorder/getallorder/"; // pakai id

  //Wallet
  static String registerWallet = "http://202.67.10.108/PAY-API/API/RegisterWallet";
  static String getWallet = "http://202.67.10.108/PAY-API/API/Wallet"; // kirim walletId di header
  static String topUpWallet = "http://202.67.10.108/PAY-API/API/TopUp"; // kirim walletId di header

  static String createBill = "http://202.67.10.108/PAY-API/API/CreateBill"; // kirim walletId di header
  static String viewBill = "http://202.67.10.108/PAY-API/API/ViewBill"; // kirim walletId di header
  static String payBill = "http://202.67.10.108/PAY-API/API/Pay"; // kirim walletId di header
}