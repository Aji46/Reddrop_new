import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/Request_view.dart';
import 'package:share/share.dart';

class RequestCard extends StatelessWidget {
  final DocumentSnapshot requestSnap;

  RequestCard({required this.requestSnap});

  void shareContact(String contactDetails) {
    Share.share(contactDetails, subject: 'Contact Information');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'phone': requestSnap['phone'].toString(),
                  'group': requestSnap['group'],
                  'hospital': requestSnap['hospital'],
                  'district': requestSnap['district'],
                  'state': requestSnap['state'],
                  'id': requestSnap.id,
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
              backgroundColor: const Color.fromARGB(255, 190, 24, 24),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    requestSnap['name'] as String? ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                  icon: const Icon(Icons.share_outlined),
                  color: const Color.fromARGB(255, 6, 135, 233),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class RequestListView extends StatelessWidget {
  final List<DocumentSnapshot> requests;

  RequestListView({required this.requests});

  @override
  Widget build(BuildContext context) {
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
        separatorBuilder: (context, index) => const SizedBox(height: 1),
        itemBuilder: (context, index) {
          final DocumentSnapshot requestSnap = requests[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: RequestCard(requestSnap: requestSnap),
            ),
          );
        },
      ),
    );
  }
}