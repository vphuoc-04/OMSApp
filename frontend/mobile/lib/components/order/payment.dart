import 'package:flutter/material.dart';

// Components
import 'package:mobile/components/order/payment_method.dart';
import 'package:mobile/components/order/payment_process.dart';

// Service
import 'package:mobile/services/cart_service.dart';

// Model
import 'package:mobile/models/cart.dart';

class Payment extends StatelessWidget {
  final CartService cartService = CartService();

  Future<double> calculateTotalPrice() async {
    List<Cart> cartItems = await cartService.getDataCart();
    double totalPrice = 0.0;

    for (var item in cartItems) {
      totalPrice += item.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: calculateTotalPrice(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } 
        else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } 
        else if (!snapshot.hasData || snapshot.data == 0) {
          return SizedBox.shrink();
        } 
        else {
          return Container(
            width: MediaQuery.of(context).size.width + 20,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 246, 246).withOpacity(0.7),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaymentMethod(), 
                SizedBox(height: 10),
                PaymentProcess(),
              ],
            ),
          );
        }
      },
    );
  }
}
