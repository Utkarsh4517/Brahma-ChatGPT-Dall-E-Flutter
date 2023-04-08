import 'package:brahma/screens/chat_screen.dart';
import 'package:brahma/screens/intro_screens/intro_page1.dart';
import 'package:brahma/screens/intro_screens/intro_page2.dart';
import 'package:brahma/screens/intro_screens/intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  bool onLastPage = false;

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenOnboarding', true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          controller: _controller,
          children: const [IntroPage1(), IntroPage2(), IntroPage3()],
        ),
        Container(
          alignment: const Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  _controller.jumpToPage(2);
                },
                child: const Text('Skip', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
              onLastPage
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ),
                        );
                        _completeOnboarding();
                      },
                      child: const Text('done', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                    )
                  : GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      child: const Text('next', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
