import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/functions/functions.dart';
import 'package:reddrop/navigator/navigator.dart';

class DonorListWidget extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey;
  final List<DocumentSnapshot> donors;

  DonorListWidget({
    required this.listKey,
    required this.donors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: donors.length,
      itemBuilder: (context, index, animation) {
        if (index >= donors.length) return const SizedBox.shrink();
        final DocumentSnapshot donorSnap = donors[index];
        return buildDonorListItem(context, donorSnap, animation);
      },
    );
  }

  Widget buildDonorListItem(BuildContext context, DocumentSnapshot donorSnap, Animation<double> animation) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
          ),
          child: InkWell(
            onTap: () => navigateToViewDonor(context, donorSnap),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 5),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 190, 24, 24),
                  radius: 30,
                  child: Text(
                    donorSnap['group'] as String? ?? '',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        donorSnap['name'] as String? ?? '',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        donorSnap['phone'].toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    PhoneUtils.shareContact(donorSnap['phone'] as String? ?? '');
                  },
                  tooltip: 'Share',
                  icon: const Icon(Icons.share_outlined),
                  color: const Color.fromARGB(255, 6, 135, 233),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 30, left: 30),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
        ),
        validator: validator,
      ),
    );
  }
}




  String? _validate(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    } else if (value.contains(' ')) {
      return 'Spaces are not allowed in $fieldName';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.contains(' ')) {
      return 'Spaces are not allowed in the phone number';
    } else if (RegExp(r'(\d)\1{9}').hasMatch(value)) {
      return 'Repeated digits are not allowed';
    }
    return null;
  }
