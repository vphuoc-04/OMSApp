import 'package:flutter/material.dart';
import 'dart:async';

// Components login
import 'package:mobile/components/login/button_login.dart';
import 'package:mobile/components/login/input_login.dart';

// Auth service
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/token_service.dart';

// Screens
import 'package:mobile/screens/layout_screen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool keyboardVisible = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  int? userId;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    final String name = nameController.text.trim();
    final String password = passwordController.text.trim();

    if (name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Username or password is required!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color.fromARGB(255, 141, 37, 37),
          duration: Duration(milliseconds: 1000),
        ),
      );
      Future.delayed(Duration(milliseconds: 1000), () {
        ScaffoldMessenger.of(context).clearSnackBars();
      });
      return;
    }

    try {
      final result = await authService.login(name, password);

      if (result['success']) {
        String token = result['token'];
        await TokenService.saveToken(token);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login successful!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromRGBO(67, 169, 162, 1),
            duration: Duration(milliseconds: 1000),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LayoutScreen(id: userId)),
        );

        print('Login successful: ${result['token']}');
      } 
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Incorrect username or password!',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color.fromARGB(255, 141, 37, 37),
          ),
        );
        Future.delayed(Duration(milliseconds: 1000), () {
          ScaffoldMessenger.of(context).clearSnackBars();
        });
        print('Login failed: ${result['message']}');
      }
    } 
    catch (error) {
      print('Error occurred: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    if (keyboardVisible) {
      _controller.forward();
    } 
    else {
      _controller.reverse();
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Logo
                AnimatedPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: keyboardVisible ? 18 : 23),
                  duration: const Duration(milliseconds: 200),
                  child: Image.asset(
                    'images/logo.png',
                    height: 100,
                  ),
                ),

                // Username input
                AnimatedPadding(
                  padding: EdgeInsets.only(top: keyboardVisible ? 0 : 10),
                  duration: const Duration(milliseconds: 200),
                  child: InputLogin(
                    hintText: 'Username',
                    controller: nameController,
                    obscureText: false,
                  ),
                ),

                // Password input
                AnimatedPadding(
                  padding: EdgeInsets.only(top: keyboardVisible ? 12 : 18),
                  duration: const Duration(milliseconds: 200),
                  child: InputLogin(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),

                // Button submit
                AnimatedPadding(
                  padding: EdgeInsets.only(top: keyboardVisible ? 12 : 18),
                  duration: const Duration(milliseconds: 200),
                  child: ButtonLogin(
                    onTap: () => login(context),
                  ),
                ),

                // Forgot password
                AnimatedPadding(
                  padding: EdgeInsets.only(top: keyboardVisible ? 12 : 18),
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color.fromRGBO(67, 169, 162, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}