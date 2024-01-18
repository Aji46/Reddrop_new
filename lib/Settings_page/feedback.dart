// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reddrop/widget/wigets.dart';



class SettingsFeedback extends StatefulWidget {
  const SettingsFeedback({Key? key}) : super(key: key);

  @override
  State<SettingsFeedback> createState() => _SettingsAccountState();
}

class _SettingsAccountState extends State<SettingsFeedback> {
  final TextEditingController _feedbackController = TextEditingController();
  final int maxCharacterCount = 400;

  @override
  Widget build(BuildContext context) {
     CustomAppBar customAppBar = CustomAppBar();
    return Stack(
      children: [

        Scaffold(
          backgroundColor: Colors.transparent,
           appBar: customAppBar.buildAppBar(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Feedback',
                              style: TextStyle(fontSize: 29),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Give your feedback through this Window that will be the best Suggection for us to improve our User interaction',
                                  style: TextStyle(
                                    fontSize: 25,
                                    //fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    // textAlign: TextAlign.center, // Corrected property name
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Form(
                            child: Container(
                              width: 250,
                              child: TextFormField(
                                controller: _feedbackController,
                                style: TextStyle(fontSize: 18),
                                maxLines: null,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                      maxCharacterCount),
                                  // Add any other formatters if needed
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: "Enter your feedback",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.send),
                                label: Text('Send'),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              )),
                          Text(
                            'THANK YOU',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
