import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reddrop/Home/home_Page/loginrequest.dart';
import 'package:reddrop/widget/requestpagewidgets.dart';
import 'package:reddrop/widget/wigets.dart';
import 'package:share/share.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    CustomAppBar customAppBar = CustomAppBar();

    return 
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: customAppBar.buildAppBar(context),
          body: RequestList(),
        );
  
  }
}

class RequestList extends StatelessWidget {
  void shareContact(String contactDetails) {
    Share.share(contactDetails, subject: 'Contact Information');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RequestCreateCard(),
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('Request').get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error loading requests'),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No requests found'),
                );
              }

              List<DocumentSnapshot> requests = snapshot.data!.docs;

              return RequestListView(requests: requests);
            },
          ),
        ),
      ],
    );
  }
}

class RequestCreateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 200,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(97, 19, 82, 153),
            blurRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const RequestSignup(),
              ));
            },
            child: const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Create a Request',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 19, 82, 153),
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




