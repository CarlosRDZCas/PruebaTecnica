import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String user = '';

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setUser(String user) {
    _prefs.setString('user', user);
    Preferences.user = user;
  }

  static getUser() {
    return _prefs.getString('user') ?? '';
  }
}
