import 'dart:convert';
import 'package:mobile/models/user.dart';
import 'dart:io';

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

  // Update user avatar
  Future<Map<String, dynamic>> updateAvatar(int id, File avatarFile) async {
    final response = await apiService.postMultipart('user/$id/upload-avatar', avatarFile);

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      
      print("Avatar updated successfully: $data");
      
      return data; 
    } 
    else {
      throw Exception('Failed to update avatar! Status code: ${response.statusCode}');
    }
  }

    // Delete avatar
  Future<Map<String, dynamic>> deleteAvatar(int id) async {
    final response = await apiService.delete('user/$id/delete-avatar');

    if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Avatar deleted successfully: $data");
        
        return data; 
    } 
    else {
        throw Exception('Failed to delete avatar! Status code: ${response.statusCode}');
    }
  }
}