import 'package:flutter/material.dart';

// Icon
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/layout/custom_navigation_bar.dart';

// Screens
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/profile_screen.dart';

class LayoutScreen extends StatefulWidget {
  final int? id;

  const LayoutScreen({super.key, required this.id});

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}
class _LayoutScreenState extends State<LayoutScreen> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      HomeScreen(),
      ProfileScreen(),  
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Center(
            child: Text(
              'Restaurant Management',
              style: GoogleFonts.pacifico(
                fontSize: 25,
                color: Color.fromRGBO(55, 55, 57, 1)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

