import 'package:brahma/screens/auth_screens/signup_page.dart';
import 'package:brahma/screens/page_view.dart';
import 'package:brahma/services/auth_service.dart';
import 'package:brahma/widgets/auth_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_icons/awesome_icons.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PageViewHome(),
        ),
      );
      
      // ignore: use_build_context_synchronously
      //Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // WRONG EMAIL
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xff3633d6), Color(0xff241666)],
        stops: [0, 1],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          toolbarHeight: 120,
          backgroundColor: Colors.transparent,
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Don't have an account?",
              style: GoogleFonts.roboto(
                color: const Color.fromARGB(115, 255, 255, 255),
                fontSize: 14,
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(108, 144, 140, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(color: Color.fromARGB(199, 255, 255, 255)),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'brahma.ai',
                  style: GoogleFonts.chivo(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(101, 255, 255, 255),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Welcome Back',
                                style: GoogleFonts.chivo(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.09,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Enter your details below',
                                style: GoogleFonts.chivo(
                                  color: const Color.fromARGB(117, 0, 0, 0),
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AuthTextField(
                                  controller: emailController,
                                  hintText: 'Email Address',
                                  obscureText: false),
                              const SizedBox(
                                height: 15,
                              ),
                              AuthTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff3c3edb),
                                        Color(0xffe19bff)
                                      ],
                                      stops: [0, 1],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.38, vertical: screenWidth * 0.02),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    foregroundColor: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    signUserIn();
                                  },
                                  child: Text(
                                    'Sign in',
                                    style: GoogleFonts.chivo(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                               SizedBox(
                                height: screenWidth * 0.0185,
                              ),
                              const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 104, 104, 104),
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin:  EdgeInsets.only(left: screenWidth* 0.037),
                                    height: 1,
                                    width: screenWidth * 0.3,
                                    color: Colors.black,
                                  ),
                                  const Text(
                                    'Or Sign in with',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 104, 104, 104),
                                    ),
                                  ),
                                  Container(
                                    margin:  EdgeInsets.only(right: screenWidth* 0.037),
                                    height: 1,
                                    width: screenWidth * 0.3,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 27),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          AuthService().signInWithGoogle(context);
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.google,
                                              color: Color(0xff241666),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Google',
                                              style: GoogleFonts.chivo(
                                                color: const Color(0xff241666),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.facebook,
                                              color: Color(0xff241666),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Facebook',
                                              style: GoogleFonts.chivo(
                                                color: const Color(0xff241666),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                               SizedBox(height: screenWidth * 0.046,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}