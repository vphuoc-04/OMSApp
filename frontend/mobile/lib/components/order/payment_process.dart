import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Service
import 'package:mobile/services/cart_service.dart';
import 'package:mobile/services/payment_service.dart';

// Model
import 'package:mobile/models/cart.dart';

class PaymentProcess extends StatelessWidget {
  final CartService cartService = CartService();
  final PaymentService paymentService = PaymentService();
  final int selectedMethodIndex;
  final List<Map<String, dynamic>> paymentMethods;

  PaymentProcess({
    required this.selectedMethodIndex,
    required this.paymentMethods,
  });

  Future<double> calculateTotalPrice() async {
    List<Cart> cartItems = await cartService.getDataCart();
    double totalPrice = 0.0;

    for (var item in cartItems) {
      totalPrice += item.price; 
    }
    return totalPrice; 
  }

  void _showPaymentInputCash(BuildContext context, double totalPrice) {
    final TextEditingController customerGivenController = TextEditingController();
    String paymentMethod = selectedMethodIndex != -1
        ? paymentMethods[selectedMethodIndex]['name']
        : 'Unknown';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Process', textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Amount: \VNĐ\t${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: customerGivenController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Customer Given Amount',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w300
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 200)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(67, 169, 162, 1)),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(255, 169, 67, 67)),
              ),
            ),
            TextButton(
              onPressed: () async {
                double? customerGiven = double.tryParse(customerGivenController.text);
                if (customerGiven == null || customerGiven < totalPrice) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid amount. Please enter a valid amount.'),
                    ),
                  );
                } 
                else {
                  try {
                    await paymentService.processPayment(totalPrice: totalPrice, customerGiven: customerGiven, paymentMethod: paymentMethod,);
                    double changeDue = customerGiven - totalPrice;
                    Navigator.of(context).pop(); 
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Payment successful. Change due: \VNĐ\t${changeDue.toStringAsFixed(2)}'),
                      ),
                    );
                  }
                  catch (err) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Payment failed: $err'),
                      ),
                    );
                  }
                }
              },
              child: Text(
                'Pay',
                style: TextStyle(color: Color.fromRGBO(67, 169, 162, 1)),
              ),
            ),
          ],
        );
      },
    );
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
                GestureDetector(
                  onTap: () {
                    if (selectedMethodIndex == -1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select Payment Method', textAlign: TextAlign.center,),
                            content: Text('You need to select a payment method before proceeding.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK', style: TextStyle(color: Color.fromRGBO(67, 162, 169, 1)),),
                              ),
                            ],
                          );
                        },
                      );
                    } 
                    else {
                      _showPaymentInputCash(context, snapshot.data!);
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        'Process',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      Icon(
                        CupertinoIcons.cart,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}