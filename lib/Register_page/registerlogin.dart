
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/Register_page.dart';
import 'package:reddrop/Register_page/sinup.dart';
import 'package:reddrop/home_Page/Home.dart';
import 'package:reddrop/home_Page/home%20grid.dart';
import 'package:reddrop/widget/wigets.dart';


class register_login extends StatefulWidget {
  const register_login({super.key});

  @override
  State<register_login> createState() => _Register_pageState();
}


class _Register_pageState extends State<register_login> {

  
 
  // ignore: non_constant_identifier_names


      int _currentIndex = 2;



  @override
  Widget build(BuildContext context) {

   CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
        //const Background_Image(),
        Scaffold(
           bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Perform navigation based on the selected index
          if (index == 0) {
         Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const Home_search(),
      ),
    );
          } else if (index == 1) {
             Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const HomeGrid(),
      ),
    );
          } else if (index == 2) {
             Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const register_login(),
      ),
    );
          }
        },
      ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
           appBar: customAppBar.buildAppBar(context),
          body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/background1.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "You Want Be a Blood Donor",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your data as Donor",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:  const Color.fromARGB(255, 153, 19, 19),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                     Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => const Signup(),
      ),
    );
                  },
                  child: const Text(
                    "Update your Profile",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 153, 19, 19),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                     Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const register_page(),
      ),
    );
                    
                  },
                  child: const Text(
                    "You want to be a Donor",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        )
      ],
    );
  }
}
