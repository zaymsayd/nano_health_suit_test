import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {

  static AppSharedPreference _instance = AppSharedPreference.internal();

  AppSharedPreference.internal();

  factory AppSharedPreference() => _instance;

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value =  prefs.getBool(key) ?? false ;
    return value;
  }

  Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value =  prefs.getInt(key) ?? -1 ;
    return value;
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value =  prefs.getString(key) ?? "" ;
    return value;
  }

  Future<List<String>> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> value =  prefs.getStringList(key) ?? [] ;
    return value;
  }

  setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  setBoolean(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  setStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, value);
  }

  clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  clearPreferenceKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}
