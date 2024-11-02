import 'package:flutter/material.dart';
import 'package:mobile/components/home/product_data.dart';

// Model
import 'package:mobile/models/product.dart';

// Components
import 'package:mobile/components/home/input_search.dart';
import 'package:mobile/components/home/categories_item.dart';

// Service
import 'package:mobile/services/product_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final ProductService productService = ProductService();
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    try {
      final productList = await productService.getAllProduct();
      setState(() {
        products = productList; 
        isLoading = false;
      });
    } 
    catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  void onCategorySelected(int index) {
    if (index == 0) { 
      fetchAllProducts(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
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
            InputSearch(
              controller: searchController,
              hintText: 'Search product...',
              obscureText: false,
            ),
            CategoriesItem(
              items: categories,
              onCategorySelected: onCategorySelected,
            ),
            isLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: CircularProgressIndicator(color: Color.fromRGBO(67, 169, 162, 1)),
                )
              : Expanded(
                  child: ProductData(products: products)
                ),
          ],
        ),
      ),
    );
  }
}
