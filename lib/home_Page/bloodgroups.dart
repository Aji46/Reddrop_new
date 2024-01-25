import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Doner_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Blood_donor_Group extends StatefulWidget {
  final String selectedBloodGroup;

  const Blood_donor_Group({Key? key, required this.selectedBloodGroup}) : super(key: key);

  @override
  State<Blood_donor_Group> createState() => _BloodGroupState();
}

class _BloodGroupState extends State<Blood_donor_Group> {
  final CollectionReference donor = FirebaseFirestore.instance.collection('Donor');
    late StreamController<List<DocumentSnapshot>> _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<List<DocumentSnapshot>>();
    _fetchData();
  }

  void _fetchData() {
    Stream<QuerySnapshot> stream = widget.selectedBloodGroup.isNotEmpty
        ? donor
            .where('group', isEqualTo: widget.selectedBloodGroup)
            .orderBy('name')
            .snapshots()
        : donor.orderBy('name').snapshots();

    stream.listen((snapshot) {
      _controller.add(snapshot.docs);
    }, onError: (error) {
      _controller.addError(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Text('Available ${widget.selectedBloodGroup} Blood Groups'),
          ),
          body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: widget.selectedBloodGroup.isNotEmpty
                  ? donor
                      .where('group', isEqualTo: widget.selectedBloodGroup)
                      .orderBy('name')
                      .snapshots()
                  : donor.orderBy('name').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error loading data"),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No Blood Group available"),
                  );
                }
                if (snapshot.hasData) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                      color: Color.fromARGB(255, 252, 252, 252),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 255, 255, 255),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 1),
                      itemBuilder: (context, index) {
                        final DocumentSnapshot donorSnap = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => ViewDonor(
                                        arguments: {
                                          'name': donorSnap['name'],
                                          'phone': donorSnap['phone'].toString(),
                                          'group': donorSnap['group'],
                                          'place': donorSnap['place'],
                                          'id': donorSnap.id,
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: 5),
                                    CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 30,
                                      child: Text(
                                        donorSnap['group'] as String? ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            donorSnap['name'] as String? ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            donorSnap['place'].toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        makeCall(donorSnap['phone'].toString());
                                      },
                                      icon: const Icon(Icons.call),
                                      color: Colors.green,
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
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  static void makeCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
