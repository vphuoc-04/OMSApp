import 'package:flutter/material.dart';
import 'package:mobile/components/order/order_product.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: OrderProduct(),
        ),
      ),
    );
  }
}