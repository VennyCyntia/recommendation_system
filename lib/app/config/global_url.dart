class GlobalUrl{
  // static String baseUrl = 'http://10.10.10.125:5000/';
  // static String baseUrl = 'http://192.168.83.184:5000';
  // static String baseUrl = 'http://192.168.1.101:5000';
  static String baseUrl = 'http://192.168.137.2:5000';

  //Login
  static String loginUser = "/login/employee";
  static String loginRestaurant = "/login/restaurant";

  static String getAllData = "/restaurant/getalldata";

  // Employee
  static String createEmployee = "/user/create";
  static String updateEmployee = "/user/update/"; // pakai id
  static String getAllEmployee = "/user";
  static String getEmployeeById = "/user/"; // pakai id
  static String deleteEmployee = "/user/delete/"; // pakai id

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
}