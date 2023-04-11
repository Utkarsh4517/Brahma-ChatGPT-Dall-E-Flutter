import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const AuthTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromRGBO(202, 202, 202, 0.424),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color.fromRGBO(202, 202, 202, 0.424),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          hintText: hintText,
          hintStyle: GoogleFonts.roboto(),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
