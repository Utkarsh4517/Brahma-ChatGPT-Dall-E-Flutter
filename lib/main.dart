import 'package:brahma/screens/on_borading%20_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:brahma/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
  runApp( ProviderScope(child: MyApp(hasSeenOnboarding: hasSeenOnboarding)));
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
        home: hasSeenOnboarding ? ChatScreen() : OnBoardingScreen(),
      );
    } //);
  }
//}
