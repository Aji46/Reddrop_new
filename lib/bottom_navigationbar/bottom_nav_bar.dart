import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: const [
        Icon(Icons.bloodtype, color: MyColors.mycolor2),
        Icon(Icons.home, color: MyColors.mycolor2),
        Icon(Icons.settings, color: MyColors.mycolor2),
      ],
      color: MyColors.mycolor1,
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      buttonBackgroundColor: MyColors.mycolor1,
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
