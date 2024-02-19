import 'package:flutter/material.dart';
import 'package:reddrop/bottom_navigationbar/bottomnav.dart';



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
        backgroundColor: Colors.white, // Set the background color of the app bar
        title: Row(
          children: [
            Text(
              'Red',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Italiana',
                fontSize: screenWidth < 600 ? 20 : 24,
              ),
            ),
            Text(
              'drop',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Italiana',
                fontSize: screenWidth < 600 ? 20 : 24,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white, // Set the background color of the body
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
                            color: const Color.fromARGB(255, 255, 0, 0),
                            fontFamily: 'Italiana',
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: 'Drop ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'Italiana',
                            fontSize: screenWidth < 600 ? 20 : 24,
                          ),
                        ),
                        TextSpan(
                          text: 'have 1000’s of donors all over India.',
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
