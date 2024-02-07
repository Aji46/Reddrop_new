import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reddrop/constant/constant.dart';

class BloodGroupDropdownFormField extends StatelessWidget {
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  BloodGroupDropdownFormField({
    required this.value,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
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
              labelStyle: TextStyle(color: Colors.black),
            ),
            child: DropdownButton<String>(
              value: value,
              onChanged: onChanged,
              items: bloodGroups.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
          );
        },
        validator: validator,
      ),
    );
  }
}


class DatePickerFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(BuildContext) onSelectDate;

   DatePickerFormField({
    required this.controller,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller:controller,
            readOnly: true,
            onTap: () {
              onSelectDate(context);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              labelText: 'Select Date Boold needed date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ],
      ),
    );
  }
}




Future<void> selectDate(BuildContext context, TextEditingController dateController) async {
  DateTime currentDate = DateTime.now();
  DateTime? selectedDate = await showDatePicker(
    context: context,
    initialDate: currentDate,
    firstDate: currentDate,
    lastDate: DateTime(currentDate.year + 1),
  );

  if (selectedDate != null && selectedDate.isAfter(currentDate)) {
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
  }
}


