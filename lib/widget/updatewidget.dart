import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';

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
                  color: Color.fromARGB(255, 255, 0, 0),
                  fontFamily: 'Italiana',
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'Drop ',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
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
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Deactivate Account',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }

  void deactivateFirebaseAccount() async {
    try {
      // Show the circular progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
        },
      );

      // Assuming you have the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Optionally, sign the user out
        await FirebaseAuth.instance.signOut();

        // Delete the user document from the "Donor" collection
        DocumentReference donorDocRef =
            FirebaseFirestore.instance.collection('Donor').doc(user.uid);
        await donorDocRef.delete();

        // Dismiss the circular progress indicator
        Navigator.of(context).pop();

        // Now, the user is deactivated, and they need to re-register to use the app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => RegisterLogin(), // Change this to your login page
          ),
        );
      }
    } catch (e) {
      // Dismiss the circular progress indicator
      Navigator.of(context).pop();

      print("Error deactivating account: $e");
      // Handle errors, e.g., show an error message to the user
    }
  }
}
