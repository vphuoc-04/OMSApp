import 'package:flutter/material.dart';
// Font
import 'package:google_fonts/google_fonts.dart';

// Screen
import 'package:mobile/screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, bottom: 70),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Restaurant Management",
              style: GoogleFonts.pacifico(
                fontSize: 32,
                color: const Color.fromRGBO(55, 55, 57, 1),
              ),
            ),
            Column(
              children: [
                const Text(
                  "Login and start working today.",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (contex) => LoginScreen()
                      )
                    );
                  },
                  child: Ink(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(67, 169, 162, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Get start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}