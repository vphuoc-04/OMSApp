import 'package:flutter/material.dart';

class CategoriesItem extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  CategoriesItem({required this.items});

  @override
  _CategoriesItemState createState() => _CategoriesItemState();
}

class _CategoriesItemState extends State<CategoriesItem> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.items.length, (index) {
          final item = widget.items[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              print("Selected item: ${item['label']}");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Color.fromRGBO(67, 169, 162, 1) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item['icon'],
                      color: isSelected ? Colors.white : Color.fromRGBO(67, 169, 162, 1),
                      size: 20,
                    ),
                    Text(
                      item['label'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Color.fromRGBO(67, 169, 162, 1),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
