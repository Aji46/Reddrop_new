import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/request.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/widget/container_pageview.dart';
import 'package:reddrop/widget/wigets.dart';

class HomeGrid extends StatefulWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  State<HomeGrid> createState() => _HomeGridState();
}

class _HomeGridState extends State<HomeGrid> {
  late DocumentSnapshot donorSnap;
  bool _isVisible = true;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: CustomAppBar().buildAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _isVisible ? 1.0 : 0.0,
              child: Column(
                children: [
                  Container(
                    height: 215,
                    margin: const EdgeInsets.all(8.0),
                    decoration: MyDecorations.pageContainerDecoration,
                    child: const Column(
                      children: [
                        Expanded(
                          child: Containerpageview(),
                        ),
                      ],
                    ),
                  ),
                  DotIndicator(
                    currentPageIndex: _currentPageIndex,
                    pageCount: (bloodGroups.length ~/ 4),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            margin: const EdgeInsets.all(8.0),
            decoration: MyDecorations.pageContainerDecoration,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: MyDecorations.bottomContainerDecoration,
                     height: MediaQuery.of(context).size.height * 0.4,
                  
                    child: MyButton(
                      text: 'Request for blood',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const Request(),
                        ));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: MyDecorations.bottomContainerDecoration,
                     height: MediaQuery.of(context).size.height * 0.4,
                   
                    child: MyButton(
                      text: 'I want to be a Donor',
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const RegisterLogin(),
                        ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
