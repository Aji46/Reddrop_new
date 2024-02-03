import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/register_form.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/widget/wigets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? bloodGroup;
  List<String> bloodGroupOptions = bloodGroups;

  final CollectionReference donor = FirebaseFirestore.instance.collection('Donor');

    bool _validateFields() {
    if (_usernameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _districtController.text.isEmpty ||
        _placeController.text.isEmpty ||
        _stateController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.isEmpty ||
        bloodGroup == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields must be filled.')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().buildAppBar(context),
      body: SafeArea(
        child: RegisterForm(
          usernameController: _usernameController,
          emailController: _emailController,
          passwordController: _passwordController,
          phoneController: _phoneController,
          districtController: _districtController,
          placeController: _placeController,
          stateController: _stateController,
          bloodGroup: bloodGroup,
          onBloodGroupChanged: (String? newValue) {
            setState(() {
              bloodGroup = newValue;
            });
          },
          onSubmit: () {
                 if (_validateFields()) {
                          String? uid = _auth.currentUser?.uid;
                          if (uid != null) {
                            registerUser();
                          } else {
                            print("object");
                          }
                        }
          },
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = _auth.currentUser;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference donor = firestore.collection('Donor');
      await donor.doc(user?.uid).set({
        'name': _usernameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'district': _districtController.text,
        'place': _placeController.text,
        'state': _stateController.text,
        'group': bloodGroup,
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const RegisterLogin(),
        ),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
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
}
