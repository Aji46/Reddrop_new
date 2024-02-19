// data_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/bottom_navigationbar/bottomnav.dart';

Future<void> fetchData(CollectionReference donorCollection,
    Function(List<String>, List<String>, List<String>) setData) async {
  final donorSnapshot = await donorCollection.get();
  Set<String> uniqueBloodGroups = {}, uniqueStates = {}, uniqueDistricts = {};

  for (var doc in donorSnapshot.docs) {
    uniqueBloodGroups.add(doc['group'] as String? ?? '');
    uniqueStates.add(doc['state'] as String? ?? '');
    uniqueDistricts.add(doc['district'] as String? ?? '');
  }

  setData(
    uniqueBloodGroups.toList(),
    uniqueStates.toList(),
    uniqueDistricts.toList(),
  );
}

// firebase_service.dart

class FirebaseService {
  final CollectionReference donorCollection =
      FirebaseFirestore.instance.collection('Donor');

  Future<void> fetchData(
      Function(List<String>, List<String>, List<String>) setData) async {
    // Your logic for fetching data goes here
    // Example: Fetching unique blood groups, states, and districts
    // and then calling setData function to update the state
    List<String> uniqueBloodGroups = [];
    List<String> uniqueStates = [];
    List<String> uniqueDistricts = [];

    setData(uniqueBloodGroups, uniqueStates, uniqueDistricts);
  }

  Stream<QuerySnapshot> getFilteredStream(String? selectedState,
      String? selectedDistrict, String? selectedBloodGroup) {
    Query filteredQuery = donorCollection.orderBy('name', descending: true);
    filteredQuery =
        filteredQuery.orderBy('state').orderBy('district').orderBy('group');
    if (selectedState != null) {
      filteredQuery = filteredQuery.where('state', isEqualTo: selectedState);
    }
    if (selectedDistrict != null) {
      filteredQuery =
          filteredQuery.where('district', isEqualTo: selectedDistrict);
    }
    if (selectedBloodGroup != null) {
      filteredQuery =
          filteredQuery.where('group', isEqualTo: selectedBloodGroup);
    }
    return filteredQuery.snapshots();
  }
}

class FirebaseUpdate {
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController districtController;
  final TextEditingController placeController;
  final TextEditingController stateController;
  final TextEditingController dateController;
  final String? bloodgroup;
  final GlobalKey<FormState> formKey;

  FirebaseUpdate({
    required this.usernameController,
    required this.phoneController,
    required this.districtController,
    required this.placeController,
    required this.stateController,
    required this.dateController,
    required this.bloodgroup,
    required this.formKey,
  });

  FirebaseUpdate copyWith({String? bloodgroup}) {
    return FirebaseUpdate(
      usernameController: usernameController,
      phoneController: phoneController,
      districtController: districtController,
      placeController: placeController,
      stateController: stateController,
      dateController: dateController,
      bloodgroup: bloodgroup ??
          this.bloodgroup, // Use the provided value or the current one
      formKey: formKey,
    );
  }

  void updateUser(BuildContext context, String uid, String? bloodgroup) async {

    try {
        showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 255, 255, 255)),),
        );
      },
    );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentReference userDocument =
            FirebaseFirestore.instance.collection('Request').doc(uid);
        await userDocument.set({
          'name': usernameController.text,
          'phone': phoneController.text,
          'district': districtController.text,
          'hospital': placeController.text,
          'state': stateController.text,
          'group': bloodgroup,
          'date': dateController.text,
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Request stored successfully"),
        duration: Duration(seconds: 2),
      ));

        // ignore: use_build_context_synchronously
       Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (ctx) => const BottomNavBar()),
  (route) => false,
);

      } else {
      }
    } catch (error) {
    }
  }
}
