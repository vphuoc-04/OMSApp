import 'package:flutter/material.dart';

class PaymentCash extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  PaymentCash({required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromRGBO(67, 169, 162, 1) 
              : Colors.white, 
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromRGBO(67, 169, 162, 1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.money,
              size: 24,
              color: isSelected
                  ? Colors.white 
                  : Color.fromRGBO(67, 169, 162, 1), 
            ),
            SizedBox(height: 5),
            Text(
              'Cash',
              style: TextStyle(
                fontSize: 14, 
                color: isSelected
                    ? Colors.white 
                    : Color.fromRGBO(67, 169, 162, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}