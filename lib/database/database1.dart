import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/constant/constant.dart';

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
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents user from dismissing the dialog
        builder: (BuildContext context) {
          return const AlertDialog(
             backgroundColor: Colors.transparent,
            content: Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 255, 255)),),
                
                SizedBox(height: 10),
                Text(
                  'User data updating...',
                  style: TextStyle(
                    color: MyColors.mycolor2,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      );

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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("User data updated successfully"),
        duration: Duration(seconds: 2),
      ));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      // Navigate to the next screen
      Navigator.of(context).pop(
        MaterialPageRoute(builder: (ctx) => const RegisterLogin(),
        ),

      );
    }
  } catch (error) {
    // Print any error that occurs during the update
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Dismiss the dialog if there's an error
  }
}

}


class DatabaseManager {
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance.collection('Request').doc(uid).set(data);
    // ignore: empty_catches
    } catch (error) {
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('Request').doc(uid).get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      }
    // ignore: empty_catches
    } catch (error) {
    }
    return null;
  }
}
