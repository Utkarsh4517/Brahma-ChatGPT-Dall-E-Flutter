import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:brahma/widgets/head_text.dart';
import 'package:brahma/widgets/body_text.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0XFFC6E1F4),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_dggAm75MbY.json',  height: screenWidth * 0.3, width: screenWidth * 0.3,
              ),
            ),
            const SizedBox(height: 80,),
            const HeadText(headText: 'Create images.'),
            const HeadText(headText: 'from dalle-e ai for free'),
            Container(
              padding: const EdgeInsets.all(30),
              child: const BodyText(bodyText: 'Unleash your creativity with DALLE-E AI! Create stunning images for free and bring your imagination to life. With DALLE-E AI, the possibilities are endless - explore new worlds, design breathtaking art, or simply have fun with your friends. So why wait? Start creating with brahma today and let your imagination run wild!'),
            )
          ],
        ),
      ),
    );
  }
}
