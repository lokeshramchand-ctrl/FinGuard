// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/Auth/loginbutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  bool isLoading = false;

  Future<void> login() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.116:3000/api/auth/login"), // Backend URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await storage.write(key: "token", value: data["token"]);
      /*  Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        */
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login Failed")));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Network error. Please try again later.")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00221F),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0), // Padding for top space
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50), // Space between logo and text
                  Text(
                    'Login to Your Account', // Title
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFABF02),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome back to Velar!', // Subtitle
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFFFABF02),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 100), // Space before fields
          // Text Fields
          Center(
            child: Column(
              children: [
                _buildTextField(emailController, "Email"),
                const SizedBox(height: 10), // Space between fields
                _buildTextField(passwordController, "Password"),
              ],
            ),
          ),

          const SizedBox(height: 50), // Space before button
          // Login Button
          LoginButton(buttonText: 'Login', onPressed: login),

          const SizedBox(height: 50), // Space before Forgot Password
          // Forgot Password Text
          GestureDetector(
            onTap: () {
              // Navigate to Forgot Password Page
            },
            child: Text(
              "Forgot Password?",
              style: GoogleFonts.playfairDisplay(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFABF02),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      width: 300,
      height: 70,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF00221F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFCD956), // Border color
          width: 1.0, // Border width
        ),
      ),
      child: TextField(
        controller: controller, // ✅ Added this to capture input
        textAlign: TextAlign.center,
        obscureText: hintText == "Password", // Hide password if needed
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.playfairDisplay(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFABF02),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
        style: GoogleFonts.albertSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFABF02),
        ),
      ),
    );
  }
}
