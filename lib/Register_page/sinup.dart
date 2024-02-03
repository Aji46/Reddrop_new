// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/Register_page.dart';
import 'package:reddrop/Register_page/update.dart';
import 'package:reddrop/widget/login%20widgets.dart';
import 'package:reddrop/widget/wigets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _Register_pageState();
}

class _Register_pageState extends State<Signup> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // final _formKey = GlobalKey<FormState>();
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');

  List<String> items = List.generate(50, (index) => 'Item $index');
  late DocumentSnapshot donorSnap;

   final FirebaseAuth _auth = FirebaseAuth.instance;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const Update(),
        ),
      );
    } catch (e) {
      print("Error signing in: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email or password. Please check your credentials."),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error signing in: $e"),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImage(),
                  const SizedBox(height: 25),
                  const CustomText(
                    text: "Account Verification",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: "You need to manage your request you want to login using your email and Your password",
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: _emailController,
                    hintText: "email",
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    hintText: "Password",
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    onPressed: _signInWithEmailAndPassword,
                    text: "Signup",
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const RegisterPage(),
                        ),
                      );
                    },
                    text: "I don't have an account",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

