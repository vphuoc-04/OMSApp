import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

// Model
import 'package:mobile/models/cart.dart';

// Service
import 'package:mobile/services/cart_service.dart'; 

class CustomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final double iconSize; 

  const CustomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.iconSize = 27.0, 
  }) : super(key: key);

  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final CartService cartService = CartService();
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCartCount();
  }

  Future<void> _loadCartCount() async {
    List<Cart> cartItems = await cartService.getDataCart();  
    int totalQuantity = cartItems.fold(0, (sum, item) => sum + item.quantity);  
    setState(() {
      cartCount = totalQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory, 
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Colors.transparent,
        ),
        child: Container(
          height: 50,
          child: NavigationBar(
            selectedIndex: widget.selectedIndex,
            onDestinationSelected: widget.onItemTapped,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  widget.selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
                  color: widget.selectedIndex == 0
                      ? const Color.fromRGBO(67, 169, 162, 1)
                      : Colors.grey,
                  size: widget.iconSize,
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Stack(
                  clipBehavior: Clip.none, 
                  children: [
                    Icon(
                    widget.selectedIndex == 1 ? IconlyBold.buy : IconlyLight.buy,
                      color: widget.selectedIndex == 1
                          ? const Color.fromRGBO(67, 169, 162, 1)
                          : Colors.grey,
                      size: widget.iconSize,
                    ),
                    if (cartCount > 0) 
                      Positioned(
                        left: 18,
                        bottom: 10,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$cartCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(
                  widget.selectedIndex == 2 ? Icons.access_time_filled : Icons.access_time,
                  color: widget.selectedIndex == 2 
                      ? const Color.fromRGBO(67, 169, 162, 1)
                      : Colors.grey,
                  size: widget.iconSize,
                ), 
                label: ''
              ),
              NavigationDestination(
                icon: Icon(
                  widget.selectedIndex == 3 ? IconlyBold.profile : IconlyLight.profile,
                  color: widget.selectedIndex == 3
                      ? const Color.fromRGBO(67, 169, 162, 1)
                      : Colors.grey,
                  size: widget.iconSize,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
