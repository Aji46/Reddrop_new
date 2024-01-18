import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Request_view.dart';
import 'package:reddrop/Register_page/Register_page.dart';
import 'package:reddrop/home_Page/Home.dart';
import 'package:reddrop/home_Page/loginrequest.dart';
import 'package:reddrop/widget/wigets.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _HomeGridState();
}

class _HomeGridState extends State<Request> {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users'); // Change to 'Users' collection

  late StreamController<List<Map<String, dynamic>>> _controller;

  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<List<Map<String, dynamic>>>();
    getAllData();
  }

  Future<void> getAllData() async {
    try {
      QuerySnapshot mainCollectionSnapshot = await usersCollection.get();

      List<Map<String, dynamic>> data = [];

      for (QueryDocumentSnapshot mainDocument in mainCollectionSnapshot.docs) {
        QuerySnapshot subCollectionSnapshot = await usersCollection
            .doc(mainDocument.id)
            .collection('Requests') // Keep 'Requests' as it is
            .get();

        for (QueryDocumentSnapshot subDocument in subCollectionSnapshot.docs) {
          Map<String, dynamic> requestData =
              subDocument.data() as Map<String, dynamic>;
          requestData['mainDocumentId'] = mainDocument.id;
          requestData['subDocumentId'] = subDocument.id;
          data.add(requestData);
        }
      } 

      _controller.add(data);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar();

    return Stack( 
      children: [
        Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const Home_search(),
                  ),
                );
              } else if (index == 2) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const register_page(),
                  ),
                );
              }
            },
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: Column(
            children: [
              Column(
                children: [
                  Container(
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
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => const requestSignup(),
                              ),
                            );
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Create a Request',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 19, 82, 153),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _controller.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Loading state
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError || !snapshot.hasData) {
                      // Error state
                      return Center(child: Text('Error loading data'));
                    }
                    List<Map<String, dynamic>> requests = snapshot.data!;
                    if (requests.isEmpty) {
                      return Center(child: Text('No requests found'));
                    }

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
                      child: ListView.builder(
  itemCount: requests.length,
  itemBuilder: (context, index) {
    var requestSnap = requests[index];

    return ListTile(
      title: Text(requestSnap['name'] as String? ?? ''),
      subtitle: Text(requestSnap['phone'].toString()),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => View_Request(
              arguments: {
                'mainDocumentId': requestSnap['mainDocumentId'],
                'subDocumentId': requestSnap['subDocumentId'],
                'name': requestSnap['name'],
                'date': requestSnap['date'],
                'phone': requestSnap['phone'].toString(),
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
    );
  },
),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
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
