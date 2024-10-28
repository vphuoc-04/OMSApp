import 'dart:convert';
import 'package:mobile/models/user.dart';

// Service
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/token_service.dart';

class UserService {
  final ApiService apiService = ApiService();
  final TokenService tokenService = TokenService();

  // Get user data by ID
  Future<User> getUserById(int id) async {
    final response = await apiService.get('user/$id');

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } 
    else {
      throw Exception('Failed to load user data!');
    }
  }
}