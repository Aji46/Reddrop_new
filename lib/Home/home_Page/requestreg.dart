import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reddrop/Home/home_Page/loginrequest.dart';
import 'package:reddrop/requestwidget/requestreg.dart';
import 'package:reddrop/widget/validation_utils.dart';
import 'package:reddrop/widget/widgets2.dart';
import 'package:reddrop/widget/widgets3.dart';
import 'package:reddrop/widget/wigets.dart';

class RegisterreqPage extends StatefulWidget {
  const RegisterreqPage({Key? key}) : super(key: key);

  @override
  State<RegisterreqPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterreqPage> {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? bloodgroup;

  bool _validateFields() {
    final controllers = [
      _usernameController,_phoneController,_districtController,
      _placeController,_stateController,_dateController,
      _emailController,_passwordController,
    ];
    if (controllers.any((controller) => controller.text.isEmpty) || bloodgroup == null) {
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: _usernameController,
                labelText: "Recipient Name",
                validator: (value) => ValidationUtils.validate(value, 'Username'),
              ),
              CustomTextFormField(
                controller: _passwordController,
                labelText: "Password",
                validator: (value) => ValidationUtils.validate(value, 'password'),
              ),
              CustomTextFormField(
                controller: _emailController,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => ValidationUtils.validateemail(value),
              ),
              DatePickerFormField(
                controller: _dateController,
                onSelectDate: _selectDate,
              ),
              BloodGroupDropdownFormField(
                value: bloodgroup,
                onChanged: (String? newValue) => setState(() => bloodgroup = newValue),
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
                labelText: "Hospital",
                validator: (value) => ValidationUtils.validate(value, 'Hospital'),
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
                          RegisterUserPage().registerUser(
                            _emailController.text,_passwordController.text,_usernameController,_phoneController,
                            _districtController,_placeController,_stateController,_dateController,
                            bloodgroup, context,
                          );
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (ctx) => const requestSignup()),
                      ),
                      child: const Text(
                        'Already have an account',
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(currentDate.year + 1),
    );

    if (selectedDate != null && selectedDate.isAfter(currentDate)) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }
}
