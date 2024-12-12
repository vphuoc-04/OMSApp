import 'package:flutter/material.dart';

// Components
import 'package:mobile/components/order/payment_cash.dart';
import 'package:mobile/components/order/payment_qr.dart';

class PaymentMethod extends StatefulWidget {
  final Function(int) onMethodSelected;
  final List<Map<String, dynamic>> paymentMethods;   

  PaymentMethod({
    required this.onMethodSelected,
    required this.paymentMethods
  });

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
        children: widget.paymentMethods.map((paymentMethod) {
          int index = widget.paymentMethods.indexOf(paymentMethod);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMethodIndex = (selectedMethodIndex == index) ? -1 : index;
              });
              widget.onMethodSelected(selectedMethodIndex);
              if (selectedMethodIndex != -1) {
                print('Selected Payment Method: ${widget.paymentMethods[selectedMethodIndex]['name']}');
              } 
              else {
                print('No Payment Method Selected');
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: paymentMethod['name'] == 'Cash'
                  ? PaymentCash(
                      isSelected: selectedMethodIndex == index,
                      onTap: () {
                        setState(() {
                          selectedMethodIndex = (selectedMethodIndex == index) ? -1 : index;
                        });
                        widget.onMethodSelected(selectedMethodIndex);
                        if (selectedMethodIndex != -1) {
                          print('Selected Payment Method: ${widget.paymentMethods[selectedMethodIndex]['name']}');
                        } 
                        else {
                          print('No Payment Method Selected');
                        }
                      },
                    )
                  : PaymentQr(
                      isSelected: selectedMethodIndex == index,
                      onTap: () {
                        setState(() {
                          selectedMethodIndex = (selectedMethodIndex == index) ? -1 : index;
                        });
                        widget.onMethodSelected(selectedMethodIndex);
                        if (selectedMethodIndex != -1) {
                          print('Selected Payment Method: ${widget.paymentMethods[selectedMethodIndex]['name']}');
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