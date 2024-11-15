import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Icon
import 'package:iconly/iconly.dart'; 

class CustomNavigationBar extends StatelessWidget {
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
            selectedIndex: selectedIndex,
            onDestinationSelected: onItemTapped,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
                  color: selectedIndex == 0
                      ? const Color.fromRGBO(67, 169, 162, 1)
                      : Colors.grey,
                  size: iconSize, 
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(
                  selectedIndex == 1 ? CupertinoIcons.cart : CupertinoIcons.cart,
                  color: selectedIndex == 1
                      ? const Color.fromRGBO(67, 169, 162, 1)
                      : Colors.grey,
                  size: iconSize, 
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(
                  selectedIndex == 2 ? IconlyBold.profile : IconlyLight.profile,
                  color: selectedIndex == 2
                      ? const Color.fromRGBO(67, 169, 162, 1)
                      : Colors.grey,
                  size: iconSize,
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
