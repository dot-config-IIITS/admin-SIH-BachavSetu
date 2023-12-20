import 'package:shared_preferences/shared_preferences.dart';

class AdminPreferences {
  static SharedPreferences? _preferences;
  static const String _keyToken = "token";
  static const String _keyState = "state";
  static const String _keyDistrict = "district";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setToken(String token) async =>
      await _preferences!.setString(_keyToken, token);

  static String? getToken() => _preferences!.getString(_keyToken);

  static Future reset() async {
    await _preferences!.remove(_keyToken);
    await _preferences!.remove(_keyState);
    await _preferences!.remove(_keyDistrict);
  }

  static Future setDistrict(String district) async =>
      await _preferences!.setString(_keyDistrict, district);

  static String? getDistrict() => _preferences!.getString(_keyDistrict);

  static Future setState(String state) async =>
      await _preferences!.setString(_keyState, state);

  static String? getState() => _preferences!.getString(_keyState);
}
