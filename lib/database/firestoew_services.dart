import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> fetchUserDataAndUpdateControllers(TextEditingController usernameController, TextEditingController phoneController) async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;
      try {
        DocumentSnapshot documentSnapshot = await _firestore.collection('Request').doc(uid).get();
        if (documentSnapshot.exists) {
          Map<String, dynamic>? data = documentSnapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            usernameController.text = data['name'] ?? '';
            phoneController.text = data['phone'] ?? '';
          }
        }
      } catch (_) {}
    }
  }
  
  // Add more methods here for fetching/updating data from Firestore
}
