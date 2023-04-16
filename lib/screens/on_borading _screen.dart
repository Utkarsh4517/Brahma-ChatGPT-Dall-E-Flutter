import 'package:brahma/screens/auth_screens/login_page.dart';
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
  final PageController _controller = PageController();

  bool onLastPage = false;

  void _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenOnboarding', true);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LogInPage()));  // PageViewHome()
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
            alignment: const Alignment(0, 0.7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black,
                        dotWidth: 25,
                        dotHeight: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(2);
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: onLastPage
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20)
                                      .copyWith(left: 50, right: 50),
                                ),
                                onPressed: () {
                                  _completeOnboarding();
                                },
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(20)
                                      .copyWith(left: 50, right: 50),
                                ),
                                onPressed: () {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
