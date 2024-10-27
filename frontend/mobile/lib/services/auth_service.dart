
import 'package:mobile/services/api_service.dart';
import 'dart:convert';

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
      return {'success': true, 'token': data['token']};
    } 
    else {
      return {'success': false, 'message': response.body};
    }
  }
}