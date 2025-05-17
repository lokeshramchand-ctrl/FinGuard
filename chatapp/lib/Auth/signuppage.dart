// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:chatapp/Auth/loginbutton.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isSellerSelected = true;
  bool isLoading = false;

  Future<void> signup() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.116:3000/api/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        */
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Signup Failed")));
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
                  const SizedBox(height: 20),
                  Text(
                    'Create Your Account',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFABF02),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Real Way to Manage Finance',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFFFABF02),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),

          const SizedBox(height: 50),

          // ✅ Input Fields
          Center(
            child: Column(
              children: [
                _buildTextField(nameController, "Name"),
                const SizedBox(height: 10),
                _buildTextField(emailController, "Email"),
                const SizedBox(height: 10),
                _buildTextField(passwordController, "Password"),
                const SizedBox(height: 100),
                const SizedBox(height: 30),

                // ✅ Signup Button
                LoginButton(
                  buttonText: isLoading ? "Processing..." : "Next",
                  onPressed: signup, // Call the signup function
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Text Field Builder
  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Container(
      width: 300,
      height: 70,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFF00221F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFFABF02), width: 1.0),
      ),
      child: TextField(
        controller: controller, // ✅ Attach controller
        textAlign: TextAlign.center,
        obscureText: hintText == "Password", // Hide password
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.playfairDisplay(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFABF02),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
        style: GoogleFonts.playfairDisplay(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Color(0xFFFABF02),
        ),
      ),
    );
  }
}
