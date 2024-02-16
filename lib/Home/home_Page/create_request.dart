import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/database/database.dart';
import 'package:reddrop/database/firestoew_services.dart';
import 'package:reddrop/widget/validation_utils.dart';
import 'package:reddrop/widget/widgets2.dart';
import 'package:reddrop/widget/widgets3.dart';
import 'package:reddrop/widget/wigets.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({Key? key}) : super(key: key);

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _districtController = TextEditingController();
  final _placeController = TextEditingController();
  final _stateController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? bloodgroup;
  late FirebaseUpdate firebaseUpdate;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
      FirestoreService.fetchUserDataAndUpdateControllers(_usernameController, _phoneController);
    firebaseUpdate = FirebaseUpdate(
      usernameController: _usernameController,phoneController: _phoneController,
      districtController: _districtController, placeController: _placeController,
      stateController: _stateController, dateController: _dateController,
      bloodgroup: bloodgroup,formKey: _formKey,);
  }

  Future<void> _getCurrentUser() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {}
  }

  bool _validateFields() {
    if (_usernameController.text.isEmpty || _phoneController.text.isEmpty || _districtController.text.isEmpty || _placeController.text.isEmpty || _stateController.text.isEmpty || _dateController.text.isEmpty ||
        bloodgroup == null) {
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
              DatePickerFormField(
                controller: _dateController,
                onSelectDate: _selectDate,
              ),
              BloodGroupDropdownFormField(
                value: bloodgroup,
                onChanged: (String? newValue) {
                  setState(() {
                    bloodgroup = newValue;
                  });
                },
                validator: (value) =>
                    ValidationUtils.validate(value, 'Please select a blood group'),
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
                          String? uid = auth.currentUser?.uid;
                          if (uid != null) {
                            firebaseUpdate.updateUser(context, uid, bloodgroup);
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(MyColors.mycolor4),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: MyColors.mycolor7),
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
