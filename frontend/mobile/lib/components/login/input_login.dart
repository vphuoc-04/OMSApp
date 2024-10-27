import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  
  const InputLogin({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText
  }) : super(key: key);

  @override
  _InputLoginState createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }
  void _toggleObscureText() {
    setState(() {
      _isObscured =! _isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscured,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 200))
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(67, 169, 162, 1))
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey[700],
            fontSize: 15,
          ),
          suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[700],
                ),
                onPressed: _toggleObscureText,
              )
            : null,
        ),
      ),
    );
  }
}