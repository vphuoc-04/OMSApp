import 'package:mobile/services/api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  Future<void> addToCart(int productId, int quantity, String name, double price) async {
    final ApiService apiService = ApiService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); 
    int? userId = prefs.getInt('user_id');

    if (token != null && userId != null) {
      final response = await apiService.post('cart/add', {
        'product_id': productId,
        'quantity': quantity,
        'name': name,
        'price': price,
        'user_id': userId,  
      });

      print("Token: $token"); 
      print("User ID: $userId");

      if (response.statusCode == 201) {
        print('Product added to cart');
      } 
      else {
        print('Error: ${response.body}');
      }
    } 
    else {
      print('User not logged in!');
    }
  }
}
