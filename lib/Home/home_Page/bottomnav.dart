// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/Home.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/pageview/pageview.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => HomePageState();
}

class HomePageState extends State<BottomNavBar> {
  var selectedIndex = 1;
  final screens = [
    const HomeSearch(),
    const MyPageView(),
     register_login(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.bloodtype,color: Colors.white,),
          Icon(Icons.home,color: Colors.white,),
          Icon(Icons.settings,color: Colors.white,)
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
      ),
      body: screens[selectedIndex],
    );
  }
}