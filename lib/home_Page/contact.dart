import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reddrop/functions/functions.dart';
import 'package:reddrop/home_Page/box.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List'),
      ),
      body: ListView.builder(
        itemCount: boxcontact.length,
        itemBuilder: (context, index) {
          final contact = boxcontact.getAt(index);

          return Slidable(
            key: Key(index.toString()),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  flex: 2,
                  onPressed: (BuildContext contextt) {
  setState(() {
    boxcontact.deleteAt(index);
  });
},

                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  foregroundColor: Color.fromARGB(255, 255, 0, 0),
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                radius: 30,
                child: Text(
                  contact.group,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.phone),
              trailing: IconButton(
                onPressed: () {
                  PhoneUtils.makeCall(contact.phone);
                },
                icon: const Icon(
                  Icons.call,
                  color: Colors.green,
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}


void makeCall(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
