import 'package:mobile/services/api_service.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService apiService = ApiService();

    // Login
  Future<Map<String, dynamic>> login(String name, String password) async {
    final response = await apiService.post('login', {
      'name': name,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      ApiService.token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('user_id', data['id']); 
      await prefs.setString('token', data['token']);

      return {'success': true, 'token': data['token'], 'id': data['id']};
    } 
    else {
      return {'success': false, 'message': response.body};
    }
  }

  // Logout
  Future<void> logout() async {
    SharedPreferences out = await SharedPreferences.getInstance();
    String? token = out.getString('token');
    await out.remove('token');
    print('Token has been removed: $token');
  }
}