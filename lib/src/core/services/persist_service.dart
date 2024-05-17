import 'package:shared_preferences/shared_preferences.dart';

class Persist {
  static late SharedPreferences _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

  //sets
  static Future<bool> setBool(String key, bool value) async => _prefs.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async => _prefs.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async => _prefs.setInt(key, value);

  static Future<bool> setString(String key, String value) async => _prefs.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async => _prefs.setStringList(key, value);

  //gets
  static bool? getBool(String key) => _prefs.getBool(key);

  static double? getDouble(String key) => _prefs.getDouble(key);

  static int? getInt(String key) => _prefs.getInt(key);

  static String? getString(String key) => _prefs.getString(key);

  static List<String>? getStringList(String key) => _prefs.getStringList(key);

  //deletes..
  static Future<bool> remove(String key) async => _prefs.remove(key);

  static Future<bool> clear() async => _prefs.clear();
}
