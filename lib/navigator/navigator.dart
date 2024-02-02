import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Doner_view.dart';

void navigateToViewDonor(BuildContext context, DocumentSnapshot donorSnap) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (ctx) => ViewDonor(
        arguments: {
          'name': donorSnap['name'],
          'phone': donorSnap['phone'].toString(),
          'group': donorSnap['group'],
          'place': donorSnap['place'],
          'district': donorSnap['district'],
          'state': donorSnap['state'],
          'id': donorSnap.id,
        },
      ),
    ),
  );
}
