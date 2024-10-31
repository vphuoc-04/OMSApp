import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class InputSearch extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const InputSearch({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText
  }) : super(key: key);
  
  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 200)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(67, 169, 162, 1))
          ),
          prefixIcon: Icon(IconlyLight.search, color: Color.fromRGBO(67, 169, 162, 1),)
        ),
      ),
    );
  }
}