// ignore: file_names
import 'package:flutter/material.dart';
import 'package:reddrop/widget/wigets.dart';



class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _ViewerState();
}

class _ViewerState extends State<About> {
  @override
  Widget build(BuildContext context) {
     CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
   
        Scaffold(
          backgroundColor: Colors.transparent,
           appBar: customAppBar.buildAppBar(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        // spreadRadius: 15,
                      )
                    ]),
                child: const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            'About',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('RedDrop is online Blood Doner apllication we can get a certain Blood group easly by filtering the doners location we can get the neraby blood doners easly . And we have the functianalty to to contact them through calls and we can share the doners detailes to others.',
                          style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,
                           height: 1.5,
                          ) ,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
