import 'package:flutter/material.dart';
import 'package:mobile/components/home/input_search.dart';
import 'package:mobile/components/home/categories_item.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.flatware, 'label': 'All'},
      {'icon': Icons.ramen_dining, 'label': 'Noddle'},
      {'icon': Icons.outdoor_grill, 'label': 'Grill'},
      {'icon': Icons.fastfood, 'label': 'Fast'},
      {'icon': Icons.rice_bowl, 'label': 'Rice'},
      {'icon': Icons.local_cafe, 'label': 'Drink'},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  InputSearch(
                    controller: searchController, 
                    hintText: 'Search product...', 
                    obscureText: false,
                  ),
                ],
              ),
            ),
            CategoriesItem(
              items: items,
            ),
          ],
        ),
      ),
    );
  }
}
