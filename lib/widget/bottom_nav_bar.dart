import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: const [
        Icon(Icons.bloodtype, color: Colors.white),
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.settings, color: Colors.white),
      ],
      color: Color.fromARGB(255, 91, 12, 12),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      buttonBackgroundColor: Color.fromARGB(255, 91, 12, 12),
      index: selectedIndex,
      height: 50,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
