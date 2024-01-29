import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Pryvacypage extends StatelessWidget {
  Pryvacypage({super.key});

//  colo=Color(Colors.white);
  Color clr = const Color.fromARGB(255, 242, 246, 246);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Privacy & policy'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text(
                "How We Collect And Use Your  Personal Data",
                style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18, color:Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(255, 0, 0, 0), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Non-Personal Information. ',
                    ),
                    TextSpan(
                      text:
                          'We may use non personal information (Usage Data/Log Data, such as your device intenet protocol ("IP")address , device name ,oprating system verios,etc. ) for any purpuse as below ',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Colors
                            .red, // Example of using a different text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(255, 0, 0, 0), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Retention. ',
                    ),
                    TextSpan(
                      text:
                          'WE will retain usage data for internal analysis purposes. usage data is genarally retained of a shorter period of time, exept when this data is used to strengthen the security or to improve the functionality of our service , or we are legally obligated to retain this data for longer time periods.',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Colors
                            .red, // Example of using a different text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(255, 0, 0, 0), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Security . ',
                    ),
                    TextSpan(
                      text:
                          'We use administrative, technical, and physical security measures to help protect your personal data .  the security of your personal data is importent to Us, but remember that no methord of transmition over the internet or methord of electronic storage is 100% secure. while we strive to use commercially accepteble means to protect your personal data , we connot guarentee its absolute security.',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Colors
                            .red, // Example of using a different text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(255, 0, 0, 0), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Changes to this privacy and policy . ',
                    ),
                    TextSpan(
                      text:
                          'we may update our privacy and policy from time to time. thuse your advised to review this page pereadically for any changes . we will notify you of any changes by posting the new privacy policy on this page . thes change are effective immediatily after they are posted on this page .',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Colors
                            .red, // Example of using a different text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, // Set your desired font size
                    color: Color.fromARGB(255, 0, 0, 0), // Set your desired text color
                  ),
                  children: [
                    TextSpan(
                      text: 'Contact Us. ',
                    ),
                    TextSpan(
                      text:
                          'if you want further information about our pryvacy policy and what iy means. please feel free to email us at  support ',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Colors
                            .red, // Example of using a different text color
                      ),
                    ),
                    TextSpan(
                      text: 'ajilesh46@gmail.com',
                      style: TextStyle(
                        fontStyle:
                            FontStyle.italic, // Example of using italic style
                        color: Color.fromARGB(255, 0, 0, 0), // Example of using a different text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
            // Padding(
            //     padding: const EdgeInsets.only(top: 30),
            //     child: Text(
            //       'Retention',
            //       style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            //     )),
            //      Padding(
            //     padding: const EdgeInsets.only(top: 30),
            //     child: Text(
            //       '',
            //       style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            //     )),
          ],
        ),
      ),
    );
  }
}