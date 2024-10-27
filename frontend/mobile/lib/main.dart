import 'package:flutter/material.dart';
// Screens
import 'package:mobile/screens/home_screen.dart';
import 'package:mobile/screens/login_screen.dart';
import 'package:mobile/screens/welcome_screen.dart';

// Services
import 'package:mobile/services/api_service.dart';
import 'package:mobile/services/token_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.runToken();
  String? token = await TokenService.loadToken();

  runApp(MyApp(initialRoute: token == null ? '/login' : '/home'));
}
class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/home' : (context) => HomeScreen()
      },
    );
  }
}