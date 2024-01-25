import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reddrop/home_Page/home%20grid.dart';
import 'package:reddrop/widget/wigets.dart';

class Createrequest extends StatefulWidget {
  const Createrequest({super.key});

  @override
  State<Createrequest> createState() => _Register_pageState();
}

class _Register_pageState extends State<Createrequest> {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  final _dateController = TextEditingController();

    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  final _formKey = GlobalKey<FormState>();
    FirebaseAuth auth = FirebaseAuth.instance;
  
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
          await FirebaseFirestore.instance.collection('Request').doc(uid).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          print("User data retrieved successfully: $data");

          // Set the values for each field based on the retrieved data
          _usernameController.text = data['name'] ?? '';
          _phoneController.text = data['phone'] ?? '';
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
    try {
      // Get the currently authenticated user
      User? user = auth.currentUser;

      if (user != null) {
        // Create a reference to the main collection
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        // Create a reference to the user's document in the main collection
        DocumentReference userDocument = users.doc(user.uid);

        // Create a reference to the subcollection 'requests' within the user's document
        CollectionReference requests = userDocument.collection('Requests');

        // Add data to the subcollection
        await requests.add({
          'name': _usernameController.text,
          'phone': _phoneController.text,
          'district': _districtController.text,
          'hospital': _placeController.text,
          'state': _stateController.text,
          'group': BloodGroup,
          'date': _dateController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Print a message
        print("Request data added to subcollection successfully!");

        // Navigate to the desired page
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const HomeGrid()));
      } else {
        print("User is null");
      }
    } catch (error) {
      print("Error updating user data: $error");
    }
  }
}




  @override
  Widget build(BuildContext context) {
        CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
    
        Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Recipient Name",
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                    Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Date:yyyy-MM-dd",
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          } else {
                              try {
                            _dateFormat.parse(value);
                          } catch (e) {
                            return 'Invalid date format';
                          }
                            return null;
                          }
                        },
                      ),
                      
                    ),
                  ),
                  
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: "Blood Group",
                                labelStyle: TextStyle(color: Colors.black)),
                            child: DropdownButton<String>(
                              value: BloodGroup,
                              onChanged: (String? newValue) {
                                setState(() {
                                  BloodGroup = newValue;
                                });
                                state.didChange(newValue);
                              },
                              items: bloodGroupOptions
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                  ),

               

         



                  
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Phone Number",
                            labelStyle: const TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _placeController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Hospital name",
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _districtController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "District",
                            labelStyle: TextStyle(color: Colors.black)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 30, left: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 255, 120, 120),
                              blurRadius: 10,
                              // spreadRadius: 15,
                            )
                          ]),
                      child: TextFormField(
                        controller: _stateController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "State",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                   ElevatedButton(
  onPressed: () {
    _updateUser(context);
  },
  style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.red),
  ),
  child: const Text(
    'Submit',
    style: TextStyle(color: Colors.black),
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
