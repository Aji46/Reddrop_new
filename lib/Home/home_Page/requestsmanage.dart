// Request_Manage.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/create_request.dart';
import 'package:reddrop/widget/requestmanagewidget.dart';
import 'package:reddrop/widget/wigets.dart';


// ... (other imports)

class Request_Manage extends StatefulWidget {
  const Request_Manage({Key? key}) : super(key: key);

  @override
  State<Request_Manage> createState() => _RequestManageState();
}

class _RequestManageState extends State<Request_Manage> {
   FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _initializeCurrentUser();
  }

  Future<void> _initializeCurrentUser() async {
    await _getCurrentUser();
    // Continue with other initialization logic if needed
  }

  Future<void> _getCurrentUser() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      setState(() {
        _currentUser = currentUser;
      });
    }
  }

  Future<void> _deleteRequest() async {
    try {
      // Query documents where 'RequestId' field is equal to _currentUser.uid
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("Request")
          .doc(_currentUser.uid);

      // Delete the document
      await documentReference.delete();
      print('Document deleted successfully.');
    } catch (e) {
      print('Error deleting document: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar().buildAppBar(context),
      body: Column(
        children: [
          CreateRequestButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const CreateRequest(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              
                  future:
                  _firestore.collection('Request').doc(_currentUser.uid).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  print('Error: ${snapshot.error}');
                  return const Center(
                    child: Text('Error loading requests'),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  print('No requests found');
                  return const Center(
                    child: Text('No requests found'),
                  );
                }

                var requestSnap = snapshot.data!.data() as Map<String, dynamic>;

                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black),
                    color: const Color.fromARGB(255, 252, 252, 252),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 255, 255, 255),
                        blurRadius: 20,
                      )
                    ],
                  ),
                  child: ListView.separated(
                    itemCount: 1,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 1),

              itemBuilder: (context, index) {
                return RequestItem(
                  requestSnap: requestSnap,
                  onDelete: () {
                    setState(() {
                      _deleteRequest();
                    });
                  },
                );
              },
            )
          );
              }
            )
          )
        ],
      ),
    );
  }
}
