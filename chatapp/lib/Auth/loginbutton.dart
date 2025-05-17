// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final String buttonText; // Add buttonText as a parameter
  final VoidCallback onPressed; // Now passing onPressed from outside

  const LoginButton({
    super.key,
    required this.buttonText,
    required this.onPressed, // Make buttonText required
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Fixed width for all buttons
      height: 70, // Fixed height for all buttons
      padding: const EdgeInsets.all(10.0), // Add padding around the button
      decoration: BoxDecoration(
        color: Color(0xFF00221F), // #FCD956 background color
        borderRadius: BorderRadius.circular(20), // Rounded corners
        border: Border.all(color: Color(0xFFFABF02), width: 5.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Color(0xFF00221F),
          backgroundColor:
              Colors.transparent, // Makes button background transparent
          elevation: 0, // Remove button shadow
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8), // Space between icon and text
            Text(
              buttonText, // Use the parameter buttonText
              style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFABF02), // Customize color as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
