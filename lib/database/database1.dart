import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';

class FirebaseDonorUpdate {
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController districtController;
  final TextEditingController placeController;
  final TextEditingController stateController;
  final String? bloodgroup;
  final GlobalKey<FormState> formKey;

  FirebaseDonorUpdate({
    required this.usernameController,
    required this.phoneController,
    required this.districtController,
    required this.placeController,
    required this.stateController,
    required this.bloodgroup,
    required this.formKey,
  });

  FirebaseDonorUpdate copyWith({String? bloodgroup}) {
    return FirebaseDonorUpdate(
      usernameController: usernameController,
      phoneController: phoneController,
      districtController: districtController,
      placeController: placeController,
      stateController: stateController,
      bloodgroup: bloodgroup ?? this.bloodgroup,
      formKey: formKey,
    );
  }

  void updateUser(BuildContext context, String uid) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentReference userDocument =
            FirebaseFirestore.instance.collection('Donor').doc(uid);
        await userDocument.set({
          'name': usernameController.text,
          'phone': phoneController.text,
          'district': districtController.text,
          'place': placeController.text,
          'state': stateController.text,
          'group': bloodgroup,
        });

        // Print a success message after the update
        print('User data updated successfully');

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const RegisterLogin()),
        );
      }
    } catch (error) {
      // Print any error that occurs during the update
      print('Error updating user data: $error');
    }
  }
}


class DatabaseManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('Request').doc(uid).set(data);
    } catch (error) {
      print("Error updating user data: $error");
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('Request').doc(uid).get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      }
    } catch (error) {
      print("Error fetching user data: $error");
    }
    return null;
  }
}
