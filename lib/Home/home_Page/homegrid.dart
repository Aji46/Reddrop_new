import 'package:flutter/material.dart';
import 'package:reddrop/Register_page/registerlogin.dart';
import 'package:reddrop/constant/constant.dart';
import 'package:reddrop/request/request.dart';
import 'package:reddrop/widget/container_pageview.dart';
import 'package:reddrop/widget/wigets.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: CustomAppBar().buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: MyDecorations.pageContainerDecoration,
              child: const Containerpageview(),
            ),
          ),
          Flexible(
            child: Container(
              height: mediaQuery.size.height * 0.3,
              margin: const EdgeInsets.all(8.0),
              decoration: MyDecorations.pageContainerDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const Request(),
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: MyDecorations.bottomContainerDecoration,
                        child: const Center(
                          child: Text(
                            'Request for Blood',
                            style: TextStyle(
                                fontSize: 25,
                                color: MyColors.mycolor3,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const RegisterLogin(),
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: MyDecorations.bottomContainerDecoration,
                        child: const Center(
                          child: Text(
                            'I want to be a Donor',
                            style: TextStyle(
                              fontSize: 25,
                              color: MyColors.mycolor3,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
