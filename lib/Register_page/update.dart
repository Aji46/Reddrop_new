// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/bottomnav.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/widget/validation_utils.dart';
import 'package:reddrop/widget/widgets2.dart';
import 'package:reddrop/widget/widgets3.dart';

class Update extends StatefulWidget {
  const Update({Key? key}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  String? bloodGroup;
  final _formKey = GlobalKey<FormState>();

 

  int _currentIndex = 2;

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      setState(() {
        _currentUser = currentUser;
      });

      // Fetch additional user data from Firestore
      await _fetchUserData(currentUser.uid);
    }
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('Donor').doc(uid).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          print("User data retrieved successfully: $data");

          // Set the values for each field based on the retrieved data
          _usernameController.text = data['name'] ?? '';
          _phoneController.text = data['phone'] ?? '';

          _districtController.text = data['district'] ?? '';
          _placeController.text = data['place'] ?? '';
          _stateController.text = data['state'] ?? '';
          bloodGroup = data['group'] ?? '';

          // Force a rebuild of the widget to update the UI
          setState(() {});
        } else {
          print("User data is null");
        }
      } else {
        print("Document does not exist for UID: $uid");
      }
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }

  void _updateUser(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      final data = {
        'name': _usernameController.text,
        'phone': _phoneController.text,
        'district': _districtController.text,
        'place': _placeController.text,
        'state': _stateController.text,
        'group': bloodGroup,
      };

      try {
        final userDocRef = FirebaseFirestore.instance
            .collection('Donor')
            .doc(_currentUser.uid);

        // Check if the user's document exists
        final userDocSnapshot = await userDocRef.get();

        if (userDocSnapshot.exists) {
          // Update existing document
          await userDocRef.update(data);
          print("Donor data updated successfully");
        } else {
          // Create a new document
          await userDocRef.set(data);
          print("New donor document created successfully");
        }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => BottomNavBar()),
        );
      } catch (error) {
        print("Error updating/creating donor data: $error");
      }
    }
  }

  void deactivateFirebaseAccount() async {
    try {
      // Assuming you have the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Optionally, sign the user out
        await FirebaseAuth.instance.signOut();

        // Delete the user document from the "Donor" collection
        DocumentReference donorDocRef =
            FirebaseFirestore.instance.collection('Donor').doc(user.uid);
        await donorDocRef.delete();

        // You may also want to delete any other related data or perform additional cleanup

        // Now, the user is deactivated, and they need to re-register to use the app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) =>
                RegisterLogin(), // Change this to your login page
          ),
        );
      }
    } catch (e) {
      print("Error deactivating account: $e");
      // Handle errors, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                              deactivateFirebaseAccount();

                              Navigator.of(context).pop();
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
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextFormField(
                controller: _usernameController,
                labelText: "Donor Name",
                validator: (value) => ValidationUtils.validate(value, 'Username'),
              ),
                 BloodGroupDropdownFormField(
                value: bloodGroup,
                onChanged: (String? newValue) {
                  setState(() {
                    bloodGroup = newValue;
                  });
                },
                validator: (value) => ValidationUtils.validate(
                    value, 'Please select a blood group'),
              ),
                   CustomTextFormField(
                controller: _phoneController,
                labelText: "Phone Number",
                keyboardType: TextInputType.phone,
                validator: (value) => ValidationUtils.validatePhoneNumber(value),
              ),
                   CustomTextFormField(
                controller: _placeController,
                labelText: "Place",
                validator: (value) => ValidationUtils.validate(value, 'Place'),
              ),
                 CustomTextFormField(
                controller: _districtController,
                labelText: "District",
                validator: (value) => ValidationUtils.validate(value, 'District'),
              ),
                  CustomTextFormField(
                controller: _stateController,
                labelText: "State",
                validator: (value) => ValidationUtils.validate(value, 'State'),
              ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              _updateUser(context);
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 192, 27, 15)),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
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
