// widgets.dart

import 'package:flutter/material.dart';
import 'package:reddrop/Doner_view/request_view.dart';
import 'package:reddrop/constant/constant.dart';

class CreateRequestButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateRequestButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 130, width: 150,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.mycolor2,
          boxShadow: const [
            BoxShadow(
              color: MyColors.mycolor3, blurRadius: 20,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: onPressed,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Create a Request",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold, color: MyColors.mycolor3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RequestItem extends StatelessWidget {
  final Map<String, dynamic> requestSnap;
  final VoidCallback onDelete;
  const RequestItem({super.key, required this.requestSnap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColors.mycolor2,
            boxShadow: const [
              BoxShadow(
                color: MyColors.mycolor5, blurRadius: 10,
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
                      'id': requestSnap['id'],
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
                        requestSnap['date'] as String? ?? '',
                        style: const TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold,
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
                      onPressed: onDelete,
                      tooltip: 'Delete',
                      icon: const Icon(
                        Icons.delete,
                      ),
                      color: MyColors.mycolor3,
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
  }
}
