import 'package:get/get.dart';
import 'package:recommendation_system/app/models/user_information.dart';
import 'package:recommendation_system/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  Future<void> onSetUserInformation({required UserInformation data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', data.user_id ?? 0);
    prefs.setString('username', data.username ?? '');
    prefs.setString('email', data.email ?? '');
    prefs.setString('no_telp', data.no_telp ?? '');
    prefs.setString('role', data.role ?? '');
    prefs.setString('preference', data.preference ?? '');
    prefs.setString('wallet_id', data.wallet_id ?? '');
  }

  Future<void> onSetRestaurantInformation({required RestaurantInformation data}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', data.restaurant_id!);
    prefs.setString('username', data.restaurant_name ?? '');
    prefs.setString('email', data.email ?? '');
    prefs.setString('no_telp', data.no_telp ?? '');
    prefs.setString('wallet_id', data.wallet_id ?? '');
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

  Future<String> onGetPreference() async {
    String isLoaded = '';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = prefs.getString('preference') ?? '';
    return isLoaded;
  }

  Future<String> onGetWalletId() async {
    String isLoaded = '';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoaded = prefs.getString('wallet_id') ?? '';
    return isLoaded;
  }

  Future<void> onRemoveWhenLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('restaurant_name');
    prefs.remove('email');
    prefs.remove('no_telp');
    prefs.remove('role');
    prefs.remove('id');
    prefs.remove('wallet_id');

    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> checkUserSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isActive = true;
    if(prefs.containsKey('tokenValue')){
      // int sessionDuration =
    }
  }
}
