import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reddrop/home_Page/contactdatabase.dart';
import 'package:url_launcher/url_launcher.dart';



class ContactListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: FutureBuilder(
        future: Hive.openBox<Contactdb>('contacts'), // Open the Hive box
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error opening Hive box: ${snapshot.error}');
            } else {
              final contactsBox = Hive.box<Contactdb>('contacts');
              final contactsList = contactsBox.values.toList();

              return ListView.builder(
                itemCount: contactsList.length,
                itemBuilder: (context, index) {
                  final contact = contactsList[index];

                  return ListTile(

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
                 
                  );
                },
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
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

