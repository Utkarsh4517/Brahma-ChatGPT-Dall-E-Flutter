import 'package:brahma/widgets/body_text.dart';
import 'package:brahma/widgets/head_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntroPage3 extends StatelessWidget {

  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFFF2DACB),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.network(
                  'https://assets7.lottiefiles.com/packages/lf20_jqenj9df.json',
                  height: screenWidth * 0.3, width: screenWidth * 0.3,
                  ),
            ),
             SizedBox(
              height: screenHeight * 0.11,
            ),
            const HeadText(headText: 'Why Ads??'),
             SizedBox(
              height: screenHeight * 0.055,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: const BodyText(
                  bodyText:
                      "Open AI API is expensive to keep this app free, I need to pay for the API. That's why ads are there."),
            ),
            SizedBox(height: screenHeight * 0.03,),
            const BodyText(bodyText: 'Made with ❤️ by Utkarsh Shrivastava'),
            SizedBox(height: screenHeight * 0.03,),
            ElevatedButton(

              onPressed: () {
                launchUrlString('https://github.com/Utkarsh4517/Brahma-ChatGPT-Dall-E-Flutter');
              },
              child: const Text('Support it by giving a star on github'),
            ),
          ],
        ),
      ),
    );
  }
}
