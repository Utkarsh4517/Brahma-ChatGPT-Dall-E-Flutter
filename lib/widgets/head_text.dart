import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadText extends StatelessWidget {
  final String headText;
  const HeadText({required this.headText, super.key});

  @override
  Widget build(BuildContext context) {
    final headFontSize = MediaQuery.of(context).size.width * 0.085;
    return Text(
      headText,
      style: GoogleFonts.chivo(
        fontSize: headFontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
