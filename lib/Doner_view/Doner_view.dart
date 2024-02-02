// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/contactdatabase.dart';
import 'package:reddrop/functions/functions.dart';
import 'package:reddrop/widget/wigets.dart';

import '../Home/home_Page/box.dart';

class ViewDonor extends StatefulWidget {
  const ViewDonor({Key? key, required this.arguments}) : super(key: key);

  final Map<String, dynamic> arguments;

  @override
  State<ViewDonor> createState() => _ViewerState();
}

class _ViewerState extends State<ViewDonor> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('Donor');
  
  late String phoneNumber;

  @override
  void initState() {
    super.initState();
    // Initialize phoneNumber in initState
    phoneNumber = widget.arguments['phone'] as String;
  }
 
  @override
  Widget build(BuildContext context) {
     CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
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
                          child: Text(
                            widget.arguments['group'] as String? ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          radius: 60,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Name  : ${widget.arguments['name'] as String? ?? ''} ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Phone : ${widget.arguments['phone'] as String? ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 115),
                      child: Row(
                        children: [
                          IconButton(
                            iconSize: 45,
                            icon: Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                       onPressed: () {
  PhoneUtils.makeCall(widget.arguments['phone'] as String? ?? '');
  setState(() {
    boxcontact.put('key_${widget.arguments['name'] as String? ?? ''}', Contactdb(name:widget.arguments['name'] as String? ?? '',group:widget.arguments['group'] as String? ?? '',phone:widget.arguments['phone'] as String? ?? ''));
  });
  
},


                            tooltip: 'Make a Call',
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          IconButton(
                            iconSize: 45,
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                         PhoneUtils.shareContact(widget.arguments['phone'] as String? ?? '');

                            },
                            tooltip: 'Share',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'City  : ${widget.arguments['place'] as String? ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'District  : ${widget.arguments['district'] as String? ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),Padding(
                      padding: const EdgeInsets.all(11),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'state  : ${widget.arguments['state'] as String? ?? ''}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
