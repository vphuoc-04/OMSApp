import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Services
import 'package:mobile/services/payment_service.dart';

// Model
import 'package:mobile/models/payment.dart';

class HistoryPayment extends StatefulWidget {
  @override
  _HistoryPaymentState createState() => _HistoryPaymentState();
}

class _HistoryPaymentState extends State<HistoryPayment> {
  final PaymentService paymentService = PaymentService();
  List<Payment> paymentHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchPaymentHistory();
  }

  // Get history payment
  Future<void> _fetchPaymentHistory() async {
    var items = await paymentService.getPaymentHistory();
    setState(() {
      paymentHistory = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (paymentHistory.isEmpty) {
      return Center(
        child: Text('Your payment is empty!'),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: paymentHistory.map((item) {
            String paymentDay = item.paymentDay != null
                ? DateFormat('dd/MM/yyyy - HH:mm:ss').format(item.paymentDay!)
                : 'No payment date';
            double revenue = item.amount - (item.changeDue ?? 0.0);
            return GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  width: 400,
                  height: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color.fromARGB(206, 177, 177, 177)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  paymentDay,
                                  style: TextStyle(
                                    fontSize: 20
                                  ),
                                ), 
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    '+ ${revenue.toStringAsFixed(2)} VNĐ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}