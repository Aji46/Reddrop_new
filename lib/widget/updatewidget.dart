import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/constant/constant.dart';

class CustomAppBar {
  final BuildContext context;

  CustomAppBar(this.context);

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Align(
        alignment: Alignment.topLeft,
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Red',
                style: TextStyle(
                  color: MyColors.mycolor4,
                  fontFamily: 'Italiana',
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'Drop ',
                style: TextStyle(
                  color: MyColors.mycolor7,
                  fontFamily: 'Italiana',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            // Show a confirmation dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirmation"),
                  content: const Text(
                      "Are you sure you want to deactivate your account?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        // Call the method to deactivate account
                        deactivateFirebaseAccount();
                      },
                      child: const Text("Yes"),
                    ),
                  ],
                );
              },
            );
          },
          child: Container(
            width: 170,
            height: 30,
            decoration: BoxDecoration(
              color: MyColors.mycolor4,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Deactivate Account',
                style: TextStyle(color: MyColors.mycolor2, fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }

  void deactivateFirebaseAccount() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                MyColors.mycolor2,
              ),
            ),
          );
        },
      );

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseAuth.instance.signOut();

        // Delete the user document from the "Donor" collection
        DocumentReference donorDocRef =
            FirebaseFirestore.instance.collection('Donor').doc(user.uid);
        await donorDocRef.delete();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => const RegisterLogin(),
          ),
        );
      }
    } catch (e) {
   
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }
}
