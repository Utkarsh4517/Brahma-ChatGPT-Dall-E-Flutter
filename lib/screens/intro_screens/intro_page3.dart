import 'package:brahma/widgets/body_text.dart';
import 'package:brahma/widgets/head_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'https://assets7.lottiefiles.com/packages/lf20_jqenj9df.json'),
            ),
            const SizedBox(
              height: 170,
            ),
            const HeadText(headText: 'Why Ads??'),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: const BodyText(
                  bodyText:
                      "Open AI API is expensive to keep this app free, I need to pay for the API. That's why ads are there, You can always buy the pro version if you want or enter your own api key to go ad-free forever"),
            ),
            const BodyText(bodyText: 'Made with ❤️ by Utkarsh Shrivastava'),
            ElevatedButton(

              onPressed: () {},
              child: const Text('Support by giving it a star on github'),
            ),
          ],
        ),
      ),
    );
  }
}
