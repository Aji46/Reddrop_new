// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/home_Page/requestsmanage.dart';
import 'package:reddrop/widget/wigets.dart';

class register_req extends StatefulWidget {
  const register_req({super.key});

  @override
  State<register_req> createState() => _Register_pageState();
}

class _Register_pageState extends State<register_req> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  int _currentIndex = 2;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Request');



  Future<void> registerUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Assuming you have a User object after registration
      User? user = auth.currentUser;

      // Assuming you have these variables defined somewhere
      // String? name, phone, district, place, state, group;

      // Assuming you have a Firestore instance initialized
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Assuming 'users' is your collection in Firestore
      CollectionReference donor = firestore.collection('Request');

      // Now you can add user data to Firestore
      await donor.doc(user?.uid).set({
        'name': _usernameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => Request_Manage(), // Change this to your login page
        ),
      );
    } catch (e) {
      print("Error during registration: $e");
      // Handle registration errors
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          print("User already exists. Try to log in");
          // You can show an alert or a message here
        }
      }
    }
  }




  

  @override
  Widget build(BuildContext context) {
       CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: SafeArea(
            child: Form(
               autovalidateMode: AutovalidateMode.onUserInteraction, 
               key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Username",labelStyle: TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }else{
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                     Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType
                            .emailAddress, // Set keyboard type to email
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Email",
                          labelStyle: const TextStyle(color: Colors.black),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                              .hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
    
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Password",labelStyle: TextStyle(color: Colors.black)
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                           return null;
                        },
                      ),
                    ),
                  ),
                      Padding(
  padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 255, 120, 120),
          blurRadius: 10,
        ),
      ],
    ),
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              onChanged: (value) {
                setState(() {}); // Trigger a rebuild when text changes
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.white,
                filled: true,
                labelText: "Phone Number",
                labelStyle: const TextStyle(color: Colors.black),
                counterText: '', // Remove the default counter text
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    '${_phoneController.text.length}/10',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                } else if (value.length != 10) {
                  return 'Phone number must be 10 digits';
                }
                return null;
              },
            ),
            // Show phone number length validation text
            if (_phoneController.text.isNotEmpty &&
                _phoneController.text.length != 10)
              Text(
                'Phone number must be 10 digits',
                style: TextStyle(color: Colors.red),
              ),
          ],
        );
      },
    ),
  ),
),


                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                      ElevatedButton(
                  onPressed: ()  {
    if (_formKey.currentState?.validate() == true) {
      registerUser(_emailController.text, _passwordController.text);
   
    }
  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                  ),
                  child: const Text('Submit'),
                ),
                        TextButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (ctx) => const HomeGrid()));

                                 Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (ctx) => const Request_Manage()));
                          },
                          child: const Text(
                            'All ready have an account',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
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
