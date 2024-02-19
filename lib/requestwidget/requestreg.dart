// register_user_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/request/requestsmanage.dart';

class RegisterUserPage {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerUser(
      String email,
      String password,
      TextEditingController usernameController,
      TextEditingController phoneController,
      TextEditingController districtController,
      TextEditingController placeController,
      TextEditingController stateController,
      TextEditingController dateController,
      String? bloodgroup,
      BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>( Color.fromARGB(255, 255, 255, 255)),),
          );
        },
      );

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = _auth.currentUser;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference donor = firestore.collection('Request');

      await donor.doc(user?.uid).set({
        'name': usernameController.text,
        'phone': phoneController.text,
        'password': password,
        'district': districtController.text,
        'hospital': placeController.text,
        'state': stateController.text,
        'group': bloodgroup,
        'date': dateController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Data stored successfully.",
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            ),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(
        MaterialPageRoute(
          builder: (ctx) => Requestmanage(),
        ),
      );
    } catch (e) {
      print("Error during registration: $e");
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          print("User already exists. Try to log in");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("email already exists. Try to log in"),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }
}
