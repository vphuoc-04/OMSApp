import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Service
import 'package:mobile/services/api_service.dart';

// Model
import 'package:mobile/models/cart.dart';

class CartService {
  // Add to cart
  Future<void> addToCart(int productId, int quantity, String name, double price, String img) async {
    final ApiService apiService = ApiService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    int? userId = prefs.getInt('user_id');

    if (token == null || userId == null) {
      print('User not logged in!');
      return;
    }

    try {
      final response = await apiService.post('cart/add', {
          'product_id': productId,
          'name': name,
          'price': price,
          'img': img,
          'user_id': userId,
        },
        extraHeaders: {
          'Authorization': 'Bearer ${ApiService.token}',
        },
      );

      if (response.statusCode == 201) {
        print('Product added to cart');
      } 
      else {
        print('Error: ${response.body}');
      }
    } 
    catch (e) {
      print('Error while adding to cart: $e');
    }
  }

  Future<List<Cart>> getDataCart() async {
    final ApiService apiService = ApiService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); 

    if (token == null) {
      return [];
    }

    try {
      final response = await apiService.get(
        'cart/data',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        
        return data.map((item) => Cart.fromJson(item)).toList();
      } 
      else {
        print('Error: ${response.body}');
        return [];
      }
    } 
    catch (e) {
      print('Error while fetching cart items: $e');
      return [];
    }
  }
}
