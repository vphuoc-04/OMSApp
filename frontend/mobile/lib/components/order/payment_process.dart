import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Service
import 'package:mobile/services/cart_service.dart';

// Model
import 'package:mobile/models/cart.dart';

class PaymentProcess extends StatelessWidget {
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
          return Center(child: Text(''));
        }
        else {
          return Container(
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Color.fromRGBO(67, 169, 162, 1), 
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \VNĐ\t${snapshot.data!.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 15
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Process',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                    ),
                    Icon(
                      CupertinoIcons.cart, color: Colors.white, size: 20,
                    )
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}
