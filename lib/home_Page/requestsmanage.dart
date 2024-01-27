import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Request_view.dart';
import 'package:reddrop/home_Page/create_request.dart';
import 'package:reddrop/widget/wigets.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Request_Manage extends StatefulWidget {
  const Request_Manage({Key? key}) : super(key: key);

  @override
  State<Request_Manage> createState() => _RequestManageState();
}

class _RequestManageState extends State<Request_Manage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
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
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 130,
              width: 150,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(97, 19, 82, 153),
                    blurRadius: 20,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const Createrequest(),
                        ),
                      );
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            "Create a Request",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 19, 82, 153),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            ),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => View_Request(
                                      arguments: {
                                        'name': requestSnap['name'],
                                        'date': requestSnap['date'],
                                        'phone':
                                            requestSnap['phone'].toString(),
                                        'group': requestSnap['group'],
                                        'hospital': requestSnap['hospital'],
                                        'district': requestSnap['district'],
                                        'state': requestSnap['state'],
                                        'id': requestSnap['id'],
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(height: 5),
                                  CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 190, 24, 24),
                                    radius: 30,
                                    child: Text(
                                      requestSnap['group'] as String? ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          requestSnap['date'] as String? ?? '',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          requestSnap['name'] as String? ?? '',
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _deleteRequest();
                                        },
                                        tooltip: 'Delete',
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                        color: const Color.fromARGB(
                                            255, 6, 135, 233),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BloodCard extends StatelessWidget {
  const BloodCard({
    Key? key,
    required this.bloodGroup,
    required this.onTap,
  }) : super(key: key);

  final String bloodGroup;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 90,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: 30,
            child: Text(
              bloodGroup,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
