import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyText extends StatelessWidget {
  final String bodyText;
  const BodyText({required this.bodyText, super.key});

  @override
  Widget build(BuildContext context) {
    final bodyFontSize = MediaQuery.of(context).size.width * 0.035;
    return Text(
      bodyText,
      style: GoogleFonts.chivo(fontSize: bodyFontSize, fontWeight: FontWeight.w500),
    );
  }
}