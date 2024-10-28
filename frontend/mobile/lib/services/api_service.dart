import 'package:http/http.dart' as http;
import 'dart:convert';

// Services
import 'package:mobile/services/token_service.dart';
class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static String? token;

  // Run token when run app
  static Future<void> runToken() async {
    token = await TokenService.loadToken();
  }

  // Post method
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: json.encode(body),
    );
  }

  // Get method
  Future<http.Response> get(String endpoint, {Map<String, String>? headers}) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    return await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (headers != null) ...headers, 
      },
    );
  }
}