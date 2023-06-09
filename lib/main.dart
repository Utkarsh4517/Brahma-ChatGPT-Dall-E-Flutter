import 'package:brahma/screens/auth_screens/auth_page.dart';
import 'package:brahma/screens/on_borading%20_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
 // RequestConfiguration requestConfiguration = RequestConfiguration();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  runApp(ProviderScope(child: MyApp(hasSeenOnboarding: hasSeenOnboarding)));
}

//Color brandColor = const Color(0XFFFADFDC);

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({required this.hasSeenOnboarding, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        //colorScheme: lightColorScheme,
      ),
      debugShowCheckedModeBanner: false,
      home:  hasSeenOnboarding ? const AuthPage() : const OnBoardingScreen(),
    );
  } //);
} 
//}
