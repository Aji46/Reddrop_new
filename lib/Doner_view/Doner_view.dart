import 'package:flutter/material.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/contact/box.dart';
import 'package:reddrop/contact/contactdatabase.dart';
import 'package:reddrop/functions/functions.dart';
import 'package:reddrop/widget/wigets.dart';

class ViewDonor extends StatefulWidget {
  const ViewDonor({Key? key, required this.arguments}) : super(key: key);

  final Map<String, dynamic> arguments;

  @override
  State<ViewDonor> createState() => _ViewerState();
}

class _ViewerState extends State<ViewDonor> {
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
      appBar: customAppBar.buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColors.mycolor2,
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
            ),
            child: Column(
              children: [
                   const SizedBox(height: 20,),
                   CircleAvatar(
                    radius: 60,
                    backgroundColor: MyColors.mycolor4,
                    child: Text(
                      widget.arguments['group'] as String? ?? '',
                      style: const TextStyle(
                        color: MyColors.mycolor2,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                
                buildInfoRow('Name', widget.arguments['name']),
                buildInfoRow('Phone', widget.arguments['phone']),
                Row(
                  children: [
                   buildIconRow(
                      Icons.call,
                      MyColors.mycolor6,
                      () {
                        setState(() {
                          boxcontact.put('key_${widget.arguments['name'] as String? ?? ''}', Contactdb(name:widget.arguments['name'] as String? ?? '',group:widget.arguments['group'] as String? ?? '',phone:widget.arguments['phone'] as String? ?? ''));
                        });
                        PhoneUtils.makeCall(phoneNumber);
                      },
                    ),
                     buildIconRow(
                  Icons.share_outlined,
                  MyColors.mycolor3,
                  () => PhoneUtils.shareContact(phoneNumber),
                ),
                  ],
                ),
               
                buildInfoRow('City', widget.arguments['place']),
                buildInfoRow('District', widget.arguments['district']),
                buildInfoRow('State', widget.arguments['state']),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          '$label: ${value as String? ?? ''}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  Widget buildIconRow(IconData icon, Color color, Function() onPressed) {
    return
     Row(
        children: [
          IconButton(
            iconSize: 45,
            icon: Icon(
              icon,
              color: color,
            ),
            onPressed: onPressed,         
            tooltip: icon == Icons.call ? 'Make a Call' : 'Share',
          ),
          const SizedBox(width: 40),
        ],
      );
    
  }
}
