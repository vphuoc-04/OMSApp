import 'package:flutter/material.dart';

// Components
import 'package:mobile/components/order/payment_cash.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedMethodIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          1, 
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: PaymentCash(
              isSelected: selectedMethodIndex == index, 
              onTap: () {
                setState(() {
                  if (selectedMethodIndex == index) {
                    selectedMethodIndex = -1; 
                  }
                  else {
                    selectedMethodIndex = index; 
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}