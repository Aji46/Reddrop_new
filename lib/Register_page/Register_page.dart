// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/widget/extention.dart';
import 'package:reddrop/widget/wigets.dart';

class register_page extends StatefulWidget {
  const register_page({super.key});

  @override
  State<register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<register_page> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  // ignore: non_constant_identifier_names
  String? BloodGroup;
  List<String> bloodGroupOptions = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-",
    "INRA"
  ];

  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');

  Future<void> registerUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Assuming you have a User object after registration
      User? user = auth.currentUser;

      // Assuming you have these variables defined somewhere
      // String? name, phone, district, place, state, group;

      // Assuming you have a Firestore instance initialized
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Assuming 'users' is your collection in Firestore
      CollectionReference donor = firestore.collection('Donor');

      // Now you can add user data to Firestore
      await donor.doc(user?.uid).set({
        'name': _usernameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'district': _districtController.text,
        'place': _placeController.text,
        'state': _stateController.text,
        'group': BloodGroup,
      });

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) =>
              const register_login(), // Change this to your login page
        ),
      );
    } catch (e) {
      print("Error during registration: $e");

      // Handle registration errors
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          print("User already exists. Try to log in");
          // You can show an alert or a message here
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email is already in use. Try logging in."),
          backgroundColor: Colors.red,
        ),
      );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Username",
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        } else if (value.contains(' ')) {
                          return 'Spaces are not allowed in the username';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      keyboardType: TextInputType
                          .emailAddress, // Set keyboard type to email
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$').hasMatch(value)) {
        return 'Please enter a valid Gmail address';
      }
      return null;
    },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 30, left: 30),
                    child: FormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Blood Group",
                              labelStyle: const TextStyle(color: Colors.black)),
                          child: DropdownButton<String>(
                            value: BloodGroup,
                            onChanged: (String? newValue) {
                              setState(() {
                                BloodGroup = newValue;
                              });
                              state.didChange(newValue);
                            },
                            items: bloodGroupOptions
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a blood group';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: "Password",
                        labelStyle: const TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 10) {
                          return 'Password must be at least 10 characters';
                        }else if(value.contains(' '))
                       {
    return 'Spaces are not allowed in the password';
  } else {
    return null;
  }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              onChanged: (value) {
                                setState(
                                    () {}); // Trigger a rebuild when text changes
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Phone Number",
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                counterText:
                                    '', // Remove the default counter text
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    '${_phoneController.text.length}/10',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Phone number is required';
  } else if (value.length != 10) {
    return 'Phone number must be 10 digits';
  } else if (value.contains(' ')) {
    return 'Spaces are not allowed in the phone number';
  } else if (RegExp(r'(\d)\1{9}').hasMatch(value)) {
    return 'Repeated digits are not allowed';
  } else {
    return null;
  }
},
                            ),
                            // Show phone number length validation text
                            if (_phoneController.text.isNotEmpty &&
                                _phoneController.text.length != 10)
                              Text(
                                'Phone number must be 10 digits',
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _placeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Place",
                          labelStyle: const TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Place is required';
                        }else if (value.contains(' ')) {
    return 'Spaces are not allowed in the Place';
  } else {
    return null;
  }
                      },
                      onSaved: (value) {
                        // Convert the value to lowercase with the first letter as capital
                        _stateController.text =
                            value!.toLowerCase().capitalizeFirstLetter();
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _districtController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "District",
                          labelStyle: const TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'District is required';
                        }else if (value.contains(' ')) {
    return 'Spaces are not allowed in the District';
  } else {
    return null;
  }
                      },
                      onSaved: (value) {
                        // Convert the value to lowercase with the first letter as capital
                        _stateController.text =
                            value!.toLowerCase().capitalizeFirstLetter();
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _stateController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "State",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'State is required';
                        }else if (value.contains(' ')) {
    return 'Spaces are not allowed in the State';
  } else {
    return null;
  }
                      },
                      onSaved: (value) {
                        // Convert the value to lowercase with the first letter as capital
                        _stateController.text =
                            value!.toLowerCase().capitalizeFirstLetter();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              registerUser(_emailController.text,
                                  _passwordController.text);
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          child: const Text('Submit',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (ctx) => const HomeGrid()));

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const register_login()));
                          },
                          child: const Text(
                            'All ready have an account',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
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
