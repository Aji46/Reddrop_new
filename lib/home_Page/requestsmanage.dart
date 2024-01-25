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
  State<Request_Manage> createState() => _HomeGridState();
}

class _HomeGridState extends State<Request_Manage> {
  int _currentIndex = 1;
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      setState(() {
        _currentUser = currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar();

    return Stack(
      children: [
        Scaffold(
   
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 110),
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
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(_currentUser.uid)
                      .collection('Requests')
                      .get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error loading requests'),
                      );
                    }

                    if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Text('No requests found'),
                      );
                    }

                    List<DocumentSnapshot> requests = snapshot.data!.docs;

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
                        itemCount: requests.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 1),
                        itemBuilder: (context, index) {
                          var requestSnap = requests[index].data()
                              as Map<String, dynamic>;

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
                                            'phone': requestSnap['phone']
                                                .toString(),
                                            'group': requestSnap['group'],
                                            'hospital':
                                                requestSnap['hospital'],
                                            'district':
                                                requestSnap['district'],
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
                                      const SizedBox(
                                        height: 5,
                                      ),
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
                                              requestSnap['date']
                                                  as String? ?? '',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              requestSnap['name']
                                                  as String? ?? '',
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
                                              // Handle sharing
                                            },
                                            tooltip: 'Share',
                                            icon: const Icon(
                                              Icons.delete,
                                            ),
                                            color: const Color.fromARGB(255, 6, 135, 233),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      )
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
