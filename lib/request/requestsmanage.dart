
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/create_request.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/widget/requestmanagewidget.dart';
import 'package:reddrop/widget/wigets.dart';

class Requestmanage extends StatefulWidget {
  const Requestmanage({Key? key}) : super(key: key);

  @override
  State<Requestmanage> createState() => _RequestManageState();
}

class _RequestManageState extends State<Requestmanage> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _currentUser;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _initializeCurrentUser();
  }

  Future<void> _initializeCurrentUser() async {
    await _getCurrentUser();
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
    setState(() {
      _isDeleting = true;
    });
         DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Request")
        .doc(_currentUser.uid);
         await documentReference.delete();
         // ignore: use_build_context_synchronously
         ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
         content: Text("Document deleted successfully.",style: TextStyle(
                    color: MyColors.mycolor2,
                    fontSize: 16,
                    ),),
                    duration: Duration(seconds: 2),
      ),
    );
  } finally {
    setState(() {
      _isDeleting = false;
    });
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
            child:
             _isDeleting
    ? const Center(
        child: CircularProgressIndicator(),
      )
    : FutureBuilder(
                  future:
                  _firestore.collection('Request').doc(_currentUser.uid).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>( Color.fromARGB(255, 255, 255, 255)),),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading requests'),
                  );
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
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
