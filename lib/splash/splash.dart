import 'package:flutter/material.dart';
import 'package:reddrop/bottom_navigationbar/bottomnav.dart';
import 'package:reddrop/constant/constant.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    await Future.delayed(const Duration(seconds: 5));
    gotoLogin();
  }

  Future<void> gotoLogin() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => const BottomNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.mycolor2, 
        title: Row(
          children: [
            Text(
              'Red',
              style: TextStyle(
                color: MyColors.mycolor4,
                fontFamily: 'Italiana',
                fontSize: screenWidth < 600 ? 20 : 24,
              ),
            ),
            Text(
              'drop',
              style: TextStyle(
                color: MyColors.mycolor7,
                fontFamily: 'Italiana',
                fontSize: screenWidth < 600 ? 20 : 24,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: MyColors.mycolor2, 
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/assets/images/background1.png',
                        width: screenWidth < 600 ? 1000 : 500,
                        height: screenWidth < 600 ? 300 : 200,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Red',
                          style: TextStyle(
                            color: MyColors.mycolor4,
                            fontFamily: 'Italiana',
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: 'Drop ',
                          style: TextStyle(
                            color: MyColors.mycolor7,
                            fontFamily: 'Italiana',
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: 'we have donors all over India.',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Text(
                    '‘your life our Best’',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: screenWidth < 600 ? 24 : 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
