import 'package:flutter/material.dart';
// Screens
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/screens/layout_screen.dart';
import 'package:mobile/screens/welcome_screen.dart';

// Services
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.runToken();
  
  String? token = await TokenService.loadToken();
  int? userId;

  if (token != null) {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('user_id');
  }

  runApp(MyApp(initialRoute: token == null ? '/login' : '/home', userId: userId));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final int? userId;

  const MyApp({super.key, required this.initialRoute, this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => userId == null 
            ? LoginScreen()
            : LayoutScreen(id: userId!) , 
      },
    );
  }
}