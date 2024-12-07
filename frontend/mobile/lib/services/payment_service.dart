import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Services
import 'package:mobile/services/api_service.dart';

// Model
import 'package:mobile/models/payment.dart';

class PaymentService {
  final ApiService apiService = ApiService();

  Future<void> processPayment({ required double totalPrice, required double customerGiven, required String paymentMethod }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      print('User not logged in!');
      throw Exception('User not logged in!');
    }

    try {
      final response = await apiService.post(
        'payment/process',
        {
          'total_price': totalPrice,
          'customer_given': customerGiven,
          'payment_method': paymentMethod,
        },
        extraHeaders: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Payment successful: ${data['change_due']} VND');
      } 
      else {
        final errorData = jsonDecode(response.body);
        print('Error: ${errorData['message']}');
        throw Exception(errorData['message']);
      }
    } 
    catch (e) {
      print('Error while processing payment: $e');
      throw e;
    }
  }

  Future<List<Payment>> getPaymentHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); 

    if (token == null) {
      return [];
    }

    try {
      final response = await apiService.get(
        'payment/history',
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        
        return data.map((item) => Payment.fromJson(item)).toList();
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