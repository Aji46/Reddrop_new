import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/request_view.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:share/share.dart';

class RequestCard extends StatelessWidget {
  final DocumentSnapshot requestSnap;

  const RequestCard({super.key, required this.requestSnap});

  void shareContact(String contactDetails) {
    Share.share(contactDetails, subject: 'Contact Information');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.mycolor2,
        boxShadow: const [
          BoxShadow(
            color: MyColors.mycolor5,
            blurRadius: 10,
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => Viewrequest(
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
              backgroundColor: MyColors.mycolor4,
              radius: 30,
              child: Text(
                requestSnap['group'] as String? ?? '',
                style: const TextStyle(
                  color: MyColors.mycolor2,
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
                  color: MyColors.mycolor3,
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

  const RequestListView({super.key, required this.requests});
  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> filteredRequests = requests.where((requestSnap) {
      var year = int.parse(requestSnap['date'].substring(0, 4));
      var month = int.parse(requestSnap['date'].substring(5, 7));
      var day = int.parse(requestSnap['date'].substring(8));
      DateTime now = DateTime.now();
      DateTime today = DateTime(now.year, now.month, now.day);
      return DateTime(year, month, day).isAfter(today);
    }).toList();

        if (filteredRequests.isEmpty) {
      return const Center(
        child: Text('No requests found'),
      );
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
        color: MyColors.mycolor2,
        boxShadow: const [
          BoxShadow(
            color: MyColors.mycolor2,
            blurRadius: 20,
          )
        ],
      ),
      child: ListView.separated(
        itemCount: filteredRequests.length,
        separatorBuilder: (context, index) => const SizedBox(height: 1),
        itemBuilder: (context, index) {
          final DocumentSnapshot requestSnap = filteredRequests[index];
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
