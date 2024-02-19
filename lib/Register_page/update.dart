import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/database/database1.dart';
import 'package:reddrop/widget/updatewidget.dart';
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
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  String? bloodGroup;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await _fetchUserData(currentUser.uid);
    }
  }

  Future<void> _fetchUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('Donor').doc(uid).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          _usernameController.text = data['name'] ?? '';
          _phoneController.text = data['phone'] ?? '';
          _districtController.text = data['district'] ?? '';
          _placeController.text = data['place'] ?? '';
          _stateController.text = data['state'] ?? '';
          bloodGroup = data['group'] ?? '';
          setState(() {});
        }
      }
    // ignore: empty_catches
    } catch (error) {
    }
  }

  bool _validateFields() {
    if ([_usernameController, _phoneController, _districtController, _placeController, _stateController].any((controller) => controller.text.isEmpty) || bloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All fields must be filled.')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context).buildAppBar(),
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
                onChanged: (String? newValue) => setState(() => bloodGroup = newValue),
                validator: (value) => ValidationUtils.validate(value, 'Please select a blood group'),
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
                        if (_validateFields()) {
                          String? uid = FirebaseAuth.instance.currentUser?.uid;
                          if (uid != null) {
                            FirebaseDonorUpdate(
                              usernameController: _usernameController,
                              phoneController: _phoneController,
                              districtController: _districtController,
                              placeController: _placeController,
                              stateController: _stateController,
                              bloodgroup: bloodGroup,
                              formKey: _formKey,
                            ).updateUser(context, uid);
                          }
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 192, 27, 15)),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
