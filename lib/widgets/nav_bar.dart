import 'package:brahma/screens/chat_screen.dart';
import 'package:brahma/screens/dalle_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = const [
    ChatScreen(),
    ImageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 50,
        child: NavigationBar(
          surfaceTintColor: Colors.white,
          selectedIndex: _selectedIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.computer), label: ""),
            NavigationDestination(icon: Icon(Icons.image), label: "")
          ],
          onDestinationSelected: _navigateBottomBar,
        ),
      ),
    );
  }
}
