import 'package:flutter/material.dart';

// Components
import 'package:mobile/components/profile/avatar_profile.dart';
import 'package:mobile/components/profile/data_profile.dart';

// Models
import 'package:mobile/models/user.dart';

// Screens
import 'package:mobile/screens/login_screen.dart';

// Services
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  final UserService userService = UserService();

  User? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id'); 

    if (userId != null) {
      try {
        userData = await userService.getUserById(userId);
      } 
      catch (e) {
        print('Error fetching user data: $e');
      } 
      finally {
        setState(() {
          isLoading = false;
        });
      }
    } 
    else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0),
                    if (userData != null)
                      Column(
                        children: [
                          AvatarProfile(user: userData!),
                          SizedBox(height: 18),
                          DataProfile(userData: userData!),
                        ],
                      ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        SizedBox(width: 113),
                        ElevatedButton(
                          onPressed: () async {
                            await authService.logout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          },
                          child: Text('Logout', style: TextStyle(fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1))),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 221, 43, 43),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 65, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}