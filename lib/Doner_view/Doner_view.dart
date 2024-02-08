import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      appBar: customAppBar.buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 10)],
            ),
            child: Column(
              children: [
                   SizedBox(height: 20,),
                   CircleAvatar(
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
                
                buildInfoRow('Name', widget.arguments['name']),
                buildInfoRow('Phone', widget.arguments['phone']),
                Row(
                  children: [
                    buildIconRow(
                      Icons.call,
                      Colors.green,
                      () => PhoneUtils.makeCall(phoneNumber),
                    ),
                     buildIconRow(
                  Icons.share_outlined,
                  Colors.blue,
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
          style: TextStyle(
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
