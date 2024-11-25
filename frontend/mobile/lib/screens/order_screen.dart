import 'package:flutter/material.dart';
import 'package:mobile/components/order/order_product.dart';
import 'package:mobile/components/order/payment.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: OrderProduct()
              ),
              Payment()
            ],
          ),
        ),
      ),
    );
  }
}