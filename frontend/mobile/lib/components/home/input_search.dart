import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// Model
import 'package:mobile/models/product.dart';

// Service
import 'package:mobile/services/product_service.dart';

class InputSearch extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Function(List<Product>) onSearchResults;
  final int selectedCategoryId; 

  const InputSearch({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onSearchResults, 
    required this.selectedCategoryId
  }) : super(key: key);
  
  @override
  _InputSearchState createState() => _InputSearchState();
}

class _InputSearchState extends State<InputSearch> {
  final ProductService productService = ProductService();
  Timer? _debounce;

  void searchProduct(String name) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (name.isEmpty) {
        if (widget.selectedCategoryId == 0) {
          widget.onSearchResults(await productService.getAllProduct());
        } 
        else {
          widget.onSearchResults(await productService.getProductsByCategory(widget.selectedCategoryId));
        }
      } 
      else {
        try {
          final result = await productService.searchProductByName(name);
          widget.onSearchResults(result);
        } 
        catch (err) {
          print("Error searching product: $err");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: searchProduct, 
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 200)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(67, 169, 162, 1))
          ),
          prefixIcon: Icon(
            IconlyLight.search, 
            color: Color.fromRGBO(67, 169, 162, 1),
          ),
        ),
      ),
    );
  }
}
