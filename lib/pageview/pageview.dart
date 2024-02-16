import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/contact.dart';
import 'package:reddrop/Home/home_Page/home%20grid.dart';


class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          HomeGrid(),
          ContactListPage(),
        ],
      ),
    );
  }
}
