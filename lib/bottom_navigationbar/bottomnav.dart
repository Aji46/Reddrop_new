// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/Home.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/constant/constant.dart';
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
    const  RegisterLogin(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.bloodtype,color: MyColors.mycolor2,),
          Icon(Icons.home,color: MyColors.mycolor2,),
          Icon(Icons.settings,color: MyColors.mycolor2,)
        ],
        color: MyColors.mycolor1,
        backgroundColor: MyColors.mycolor2,
        buttonBackgroundColor: MyColors.mycolor1,
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