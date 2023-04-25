import 'package:brahma/screens/auth_screens/login_page.dart';
import 'package:brahma/screens/page_view.dart';
import 'package:brahma/services/auth_service.dart';
import 'package:brahma/widgets/auth_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_icons/awesome_icons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      // if confirm password == password?
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        userCredential.user!.updateDisplayName(nameController.text);
      } else {
        Navigator.pop(context); // Dismiss the dialog
        showErrorMessage("Passwords don't match");
        return;
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PageViewHome(),
        ),
      );
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
              "Already have an account?",
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInPage()));
                },
                child: const Text(
                  'Sign In',
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
                    fontSize: screenWidth * 0.1,
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
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.7,
                          ),
                          height: MediaQuery.of(context).size.height * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Get Started free.',
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
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                AuthTextField(
                                    controller: nameController,
                                    hintText: 'Your Name',
                                    obscureText: false),
                                const SizedBox(
                                  height: 15,
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
                                AuthTextField(
                                    controller: confirmPasswordController,
                                    hintText: 'Confirm Password',
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.38,
                                          vertical: screenWidth * 0.02),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                      surfaceTintColor: Colors.transparent,
                                    ),
                                    onPressed: signUserUp,
                                    child: Text(
                                      'Sign Up',
                                      style: GoogleFonts.chivo(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
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
                                        'Or Sign up with',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 104, 104, 104),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                             EdgeInsets.only(right: screenWidth* 0.037),
                                        height: 1,
                                        width: screenWidth * 0.3,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
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
                                            AuthService()
                                                .signInWithGoogle(context);
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
                                                  color:
                                                      const Color(0xff241666),
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
                                                  color:
                                                      const Color(0xff241666),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
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
        ),
      ),
    );
  }
}
