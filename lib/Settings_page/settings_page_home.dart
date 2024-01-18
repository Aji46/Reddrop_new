// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/Register_page/sinup.dart';
import 'package:reddrop/Settings_page/about.dart';
import 'package:reddrop/Settings_page/feedback.dart';
import 'package:reddrop/widget/wigets.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
        // const Background_Image(),
        Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
           appBar: customAppBar.buildAppBar(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    InkWell(
                      onTap: () {

showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Do You Have an Account?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const Signup(),
              ),
            );
          },
          child: Text(
            'Yes',
            style: TextStyle(
              color: Colors.blue, // Customize the text color
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const register_login(),
              ),
            );
          },
          child: Text(
            'No',
            style: TextStyle(
              color: Colors.red, // Customize the text color
            ),
          ),
        ),
      ],
      // You can customize other properties like backgroundColor, elevation, shape, etc.
      // For example:
      backgroundColor: Colors.white,
     
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  },
);






                      
                      },
                      child: Container(
                        width: 290,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 100, top: 20),
                          child: Text(
                            'Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const SettingsFeedback()));
                      },
                      child: Container(
                          width: 290,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                // spreadRadius: 15,
                              )
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 100, top: 20),
                            child: Text(
                              'Feedback',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                            
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const About()));
                      },
                      child: Container(
                          width: 290,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10,
                                // spreadRadius: 15,
                              )
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 100, top: 20),
                            child: Text(
                              'About',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Container(
                            width: 290,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromARGB(0, 255, 255, 255),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(0, 158, 158, 158),
                                  blurRadius: 10,
                                  // spreadRadius: 15,
                                )
                              ],
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 100,),
                              child: Text(
                                'Version 1',
                                style: TextStyle(fontSize: 18,color: Colors.grey),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
