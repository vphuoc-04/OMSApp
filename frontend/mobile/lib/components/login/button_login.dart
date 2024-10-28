import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final Function()? onTap;

  const ButtonLogin({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color.fromRGBO(67, 169, 162, 1),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}