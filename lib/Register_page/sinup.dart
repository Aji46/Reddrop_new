
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/Register_page.dart';
import 'package:reddrop/Register_page/update.dart';
import 'package:reddrop/widget/loginwidgets.dart';
import 'package:reddrop/widget/wigets.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => RegisterPagestate();
}


class RegisterPagestate extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final CollectionReference donor = FirebaseFirestore.instance.collection('Request');

  @override
  void initState() {
    super.initState();
    _emailController;
    _passwordController;
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>( Color.fromARGB(255, 255, 255, 255)),)));
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
     if (userCredential != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),
          duration: Duration(seconds: 2),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const Update()));
    }
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid email or password. Please check your credentials."), duration: Duration(seconds: 3)));
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error signing in: $e"), duration: const Duration(seconds: 3)));
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
    return Stack(children: [
      Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: CustomAppBar().buildAppBar(context),
        body: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CustomImage(),
              const SizedBox(height: 25),
              const CustomText(text: "Account Verification", fontSize: 22, fontWeight: FontWeight.bold),
              const SizedBox(height: 10),
              const CustomText(text: "You need to manage your request you want to login using your email and Your password", fontSize: 16, textAlign: TextAlign.center),
              const SizedBox(height: 30),
              CustomTextField(controller: _emailController, hintText: "email", keyboardType: TextInputType.emailAddress,obscureText: false),
              const SizedBox(height: 15),
              CustomTextField(controller: _passwordController, keyboardType: TextInputType.visiblePassword, obscureText: true, hintText: "Password"),
              const SizedBox(height: 20),
              CustomElevatedButton(onPressed: _signInWithEmailAndPassword, text: "Signup"),
              CustomTextButton(
                onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const RegisterPage())),
                text: "I don't have an account",
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
