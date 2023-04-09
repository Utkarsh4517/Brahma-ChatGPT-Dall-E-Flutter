import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brahma/widgets/head_text.dart';
import 'package:brahma/widgets/body_text.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final headFontSize = MediaQuery.of(context).size.width * 0.09;
    final bodyFontSize = MediaQuery.of(context).size.width * 0.035;
    return Scaffold(
      backgroundColor: const Color(0XFFD9CFFF),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Lottie.network(
                'https://assets9.lottiefiles.com/packages/lf20_u7Kb8Mmewc.json',
              ),
            ),
            const HeadText(headText: 'Meet brahma.'),
            Text(
              'your personal ai bot',
              style: GoogleFonts.chivo(
                fontSize: headFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: const BodyText(bodyText: 'a powerful and intuitive virtual assistant that is always at your service. With Brahma, you can streamline your daily tasks, get instant answers to your questions, and enjoy a more personalized and efficient experience on your device'),
            )
          ],
        ),
      ),
    );
  }
}
