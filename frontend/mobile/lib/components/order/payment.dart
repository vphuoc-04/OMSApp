import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Components
import 'package:mobile/components/order/payment_process.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width + 20, 
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 246, 246, 246).withOpacity(0.7), 
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentProcess(),
        ],
      ),
    );
  }
}
