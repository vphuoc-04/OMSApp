import 'package:flutter/material.dart';
import 'package:mobile/components/order/order_product.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: OrderProduct(),
        ),
      ),
    );
  }
}