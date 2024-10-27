import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'token';
  // Save token
  static Future<void> saveToken(String token) async {
    final save = await SharedPreferences.getInstance();
    await save.setString(_tokenKey, token);
  }
  // Load token
  static Future<String?> loadToken() async {
    final save = await SharedPreferences.getInstance();
    await save.getString(_tokenKey);
  }
  //  Remove token
  static Future<void> removeToken() async {
    final save = await SharedPreferences.getInstance();
    await save.remove(_tokenKey);
  }
}