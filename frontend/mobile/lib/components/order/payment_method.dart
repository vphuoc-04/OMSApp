import 'package:flutter/material.dart';

// Components
import 'package:mobile/components/order/payment_cash.dart';

class PaymentMethod extends StatefulWidget {
  final Function(int) onMethodSelected;  

  PaymentMethod({required this.onMethodSelected});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int selectedMethodIndex = -1; 

  final List<Map<String, dynamic>> paymentMethods = [
    { 'name': 'Cash', },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: paymentMethods.map((paymentMethod) {
          int index = paymentMethods.indexOf(paymentMethod);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedMethodIndex = (selectedMethodIndex == index) ? -1 : index;
                });
                widget.onMethodSelected(selectedMethodIndex);
                if (selectedMethodIndex != -1) {
                  print('Selected Payment Method: ${paymentMethods[selectedMethodIndex]['name']}');
                } 
                else {
                  print('No Payment Method Selected');
                }
              },
              child: PaymentCash(
                isSelected: selectedMethodIndex == index, 
                onTap: () {
                  setState(() {
                    selectedMethodIndex = (selectedMethodIndex == index) ? -1 : index;
                  });
                  widget.onMethodSelected(selectedMethodIndex);
                  if (selectedMethodIndex != -1) {
                    print('Selected Payment Method: ${paymentMethods[selectedMethodIndex]['name']}');
                  } 
                  else {
                    print('No Payment Method Selected');
                  }
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}