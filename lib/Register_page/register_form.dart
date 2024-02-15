import 'package:flutter/material.dart';
import 'package:reddrop/widget/validation_utils.dart';
import 'package:reddrop/widget/widgets2.dart';
import 'package:reddrop/widget/widgets3.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController districtController;
  final TextEditingController placeController;
  final TextEditingController stateController;
  final String? bloodGroup;
  final Function(String?) onBloodGroupChanged;
  final VoidCallback onSubmit;

   RegisterForm({
    Key? key,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.districtController,
    required this.placeController,
    required this.stateController,
    required this.bloodGroup,
    required this.onBloodGroupChanged,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextFormField(
                controller: usernameController,
                labelText: "Donor Name",
                validator: (value) => ValidationUtils.validate(value, 'Username'),
              ),
              CustomTextFormField(
                controller: emailController,
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => ValidationUtils.validateemail(value),
              ),
              BloodGroupDropdownFormField(
                value: bloodGroup,
                onChanged: onBloodGroupChanged,
                validator: (value) => ValidationUtils.validate(value, 'Please select a blood group'),
              ),
              CustomTextFormField(
                controller: passwordController,
                labelText: "Password",
                validator: (value) => ValidationUtils.validate(value, 'Password'),
              ),
              CustomTextFormField(
                controller: phoneController,
                labelText: "Phone Number",
                keyboardType: TextInputType.number,
                validator: (value) => ValidationUtils.validatePhoneNumber(value),
              ),
              CustomTextFormField(
                controller: placeController,
                labelText: "Place",
                validator: (value) => ValidationUtils.validate(value, 'Place'),
              ),
              CustomTextFormField(
                controller: districtController,
                labelText: "District",
                validator: (value) => ValidationUtils.validate(value, 'District'),
              ),
              CustomTextFormField(
                controller: stateController,
                labelText: "State",
                validator: (value) => ValidationUtils.validate(value, 'State'),
              ),
              buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: onSubmit,
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.red),
            ),
            child: const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
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
    );
  }
}
