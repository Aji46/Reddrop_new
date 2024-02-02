// register_user_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/requestsmanage.dart';

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

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => Request_Manage(),
        ),
      );
    } catch (e) {
      print("Error during registration: $e");
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
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
