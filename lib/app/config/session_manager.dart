import 'package:recommendation_system/app/models/user_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  Future<void> onSetUserInformation({required UserInformation data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', data.username ?? '');
    prefs.setString('email', data.email ?? '');
    prefs.setString('no_telp', data.no_telp ?? '');
    prefs.setString('role', data.role ?? '');
  }

  Future<void> onSetRestaurantInformation({required RestaurantInformation data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', data.restaurant_id!);
    prefs.setString('username', data.restaurant_name ?? '');
    prefs.setString('email', data.email ?? '');
    prefs.setString('no_telp', data.no_telp ?? '');
  }

  Future<int> onGetId() async {
    int isLoaded = 0;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = prefs.getInt('id') ?? 0;
    return isLoaded;
  }

  Future<String> onGetUsername() async {
    String isLoaded = '';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = prefs.getString('username') ?? '';
    return isLoaded;
  }

  Future<String> onGetEmail() async {
    String isLoaded = '';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = prefs.getString('email') ?? '';
    return isLoaded;
  }

  Future<String> onGetNoTelepon() async {
    String isLoaded = '';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = prefs.getString('no_telp') ?? '';
    return isLoaded;
  }

  Future<void> onRemoveWhenLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('restaurant_name');
    prefs.remove('email');
    prefs.remove('no_telp');
  }
}
