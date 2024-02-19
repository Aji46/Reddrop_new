import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/request/requestreg.dart';
import 'package:reddrop/request/requestsmanage.dart';
import 'package:reddrop/widget/login%20widgets.dart';
import 'package:reddrop/widget/wigets.dart';

class RequestSignup extends StatefulWidget {
  const RequestSignup({super.key});
  @override
  State<RequestSignup> createState() => _register_pagestate();
}


class _register_pagestate extends State<RequestSignup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final CollectionReference donor = FirebaseFirestore.instance.collection('Request');
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _emailController;
    _passwordController;
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.mycolor2),)));
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const Requestmanage()));
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
        backgroundColor: MyColors.mycolor2,
        appBar: CustomAppBar().buildAppBar(context),
        body: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomImage(),
              const SizedBox(height: 25),
              const CustomText(text: "Account Verification", fontSize: 22, fontWeight: FontWeight.bold),
              const SizedBox(height: 10),
              const CustomText(text: "You need to manage your request you want to login using your email and Your password", fontSize: 16, textAlign: TextAlign.center),
              const SizedBox(height: 30),
              CustomTextField(controller: _emailController, hintText: "email"),
              const SizedBox(height: 15),
              CustomTextField(controller: _passwordController, keyboardType: TextInputType.visiblePassword, obscureText: true, hintText: "Password"),
              const SizedBox(height: 20),
              CustomElevatedButton(onPressed: _signInWithEmailAndPassword, text: "Signup"),
              CustomTextButton(
                onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const RegisterreqPage())),
                text: "I don't have an account",
              ),
            ]),
          ),
        ),
      ),
    ]);
  }
}
