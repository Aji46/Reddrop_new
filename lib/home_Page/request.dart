import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Request_view.dart';
import 'package:reddrop/Settings_page/settings_page_home.dart';
import 'package:reddrop/home_Page/loginrequest.dart';
import 'package:share/share.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _HomeGridState();

}

class _HomeGridState extends State<Request> {


void fetchRequestsForAllUsers() async {
  // Step 1: Get all user documents from 'users' collection
  QuerySnapshot<Map<String, dynamic>> usersSnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  // Step 2: Extract user IDs from the documents
  List<String> userIds = usersSnapshot.docs.map((doc) => doc.id).toList();

  // Step 3: Use each user ID to query the 'Requests' subcollection
  for (String userId in userIds) {
    QuerySnapshot<Map<String, dynamic>> requestsSnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(userId)
        .collection('Requests')
        .get();

    // Process the requests for the current user
    for (QueryDocumentSnapshot<Map<String, dynamic>> requestDoc
        in requestsSnapshot.docs) {
      // Access the request data using requestDoc.data()
      Map<String, dynamic> requestData = requestDoc.data();
      print('User ID: $userId, Request Data: $requestData');
    }

  }
}

  void shareContact(String contactDetails) {
    Share.share(contactDetails, subject: 'Contact Information');
  }


  @override
  void initState() {
    super.initState();
    fetchRequestsForAllUsers();

}
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        // const Background_Image(),
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Red',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontFamily: 'Italiana',
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: 'Drop ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: 'Italiana',
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const Setting(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 130,
                width: 200,
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const requestSignup(),
                        ));
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(left:15.0),
                          child: Text(
                            'Create a Request',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 19, 82, 153)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
    .collection('users')
    .doc()  // You might need to replace 'userId' with the actual user ID
    .collection('Requests')
    .orderBy('timestamp', descending: true)
    .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
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
                          itemCount: snapshot.data!.docs.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 1),
                          itemBuilder: (context, index) {
                            final DocumentSnapshot requestSnap =
                                snapshot.data!.docs[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
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

                                              'id': requestSnap.id,
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
                                            requestSnap['group'] as String? ??
                                                '',
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
                                                requestSnap['name']
                                                        as String? ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                requestSnap['district'].toString(),
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
                                                shareContact(
                                                    '${requestSnap['name'] as String? ?? ''} ${requestSnap['phone']}');
                                              },
                                              tooltip: 'Share',
                                              icon: const Icon(
                                                  Icons.share_outlined),
                                              color: const Color.fromARGB(
                                                  255, 6, 135, 233),
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
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
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
  const BloodCard({Key? key, required this.bloodGroup, required this.onTap})
      : super(key: key);

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
