import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/functions/functions.dart';
import 'package:reddrop/widget/wigets.dart';

class Viewrequest extends StatefulWidget {
  const Viewrequest({Key? key, required this.arguments}) : super(key: key);

  final Map<String, dynamic> arguments;

  @override
  State<Viewrequest> createState() => _ViewerState();
}

class _ViewerState extends State<Viewrequest> {
  final CollectionReference request =
      FirebaseFirestore.instance.collection('Request');

  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.arguments['phone'] as String;
  }

  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar();
    return Scaffold(
      backgroundColor: MyColors.mycolor2,
      appBar: customAppBar.buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColors.mycolor2,
              boxShadow: const [
                BoxShadow(
                  color: MyColors.mycolor5,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 120, top: 50),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: MyColors.mycolor4,
                      child: Text(
                        widget.arguments['group'] as String? ?? '',
                        style: const TextStyle(
                          color: MyColors.mycolor2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                buildText('Name', widget.arguments['name'] as String? ?? ''),
                buildText('Blood wanted Date', widget.arguments['date'] as String? ?? ''),
                buildText('Phone', widget.arguments['phone'] as String? ?? ''),
                buildRow(Icons.call, Colors.green, () {
                  PhoneUtils.makeCall(widget.arguments['phone'] as String? ?? '');
                }, Icons.share_outlined, Colors.blue, () {
                  PhoneUtils.shareContact(widget.arguments['phone'] as String? ?? '');
                }),
                buildText('Hospital', widget.arguments['hospital'] as String? ?? ''),
                buildText('District', widget.arguments['district'] as String? ?? ''),
                buildText('State', widget.arguments['state'] as String? ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          '$label: $value',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  Widget buildRow(IconData icon1, Color color1, Function() onPressed1, IconData icon2, Color color2, Function() onPressed2) {
    return Padding(
      padding: const EdgeInsets.only(left: 115),
      child: Row(
        children: [
          IconButton(
            iconSize: 45,
            icon: Icon(
              icon1,
              color: color1,
            ),
            onPressed: onPressed1,
            tooltip: 'Make a Call',
          ),
          const SizedBox(
            width: 40,
          ),
          IconButton(
            iconSize: 45,
            icon: Icon(
              icon2,
              color: color2,
            ),
            onPressed: onPressed2,
            tooltip: 'Share',
          ),
        ],
      ),
    );
  }
}
