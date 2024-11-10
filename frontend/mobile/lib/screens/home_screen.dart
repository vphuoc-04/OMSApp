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

  int selectedCategoryId = 0;

  final List<Map<String, dynamic>> categories = [
    {'id': 0, 'icon': Icons.flatware, 'label': 'All'},
    {'id': 1, 'icon': Icons.ramen_dining, 'label': 'Noodle'},
    {'id': 2, 'icon': Icons.outdoor_grill, 'label': 'Grill'},
    {'id': 3, 'icon': Icons.fastfood, 'label': 'Fast'},
    {'id': 4, 'icon': Icons.rice_bowl, 'label': 'Rice'},
    {'id': 5, 'icon': Icons.local_cafe, 'label': 'Drink'},
  ];

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  void onCategorySelected(int index) {
    final categoryId = categories[index]['id'];
    setState(() {
      selectedCategoryId = categoryId;
      isLoading = true;
    });

    if (categoryId == 0) {
      fetchAllProducts(); 
    } 
    else {
      fetchProductsByCategory(categoryId); 
    }
  }

  Future<void> fetchAllProducts() async {
    try {
      final productList = await productService.getAllProduct();
      setState(() {
        products = productList;
        isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      final productList = await productService.getProductsByCategory(categoryId);
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

  void updateSearchResults(List<Product> results) {
    setState(() {
      products = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          children: [
            InputSearch(
              controller: searchController,
              hintText: 'Search product...',
              obscureText: false,
              onSearchResults: updateSearchResults,
              selectedCategoryId: selectedCategoryId,
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
