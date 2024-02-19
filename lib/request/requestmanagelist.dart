import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/request_view.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class Requestlist extends StatefulWidget {
  const Requestlist({Key? key}) : super(key: key);

  @override
  State<Requestlist> createState() => _RequestlistState();
}

class _RequestlistState extends State<Requestlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Request').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return ListView.separated(
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
                      color: MyColors.mycolor2,
                      boxShadow: const [BoxShadow(color: MyColors.mycolor5, blurRadius: 10)],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => Viewrequest(
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
                            backgroundColor: MyColors.mycolor4,
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
                            color: MyColors.mycolor6,
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static void makeCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
