import 'package:flutter/material.dart';

class Pryvacypage extends StatelessWidget {
  Pryvacypage({super.key});

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
            _buildText(
              "How We Collect And Use Your Personal Data",
              FontWeight.w700,
              18,
              Colors.black,
            ),
            _buildRichText(
              'Non-Personal Information.',
              'We may use non personal information (Usage Data/Log Data, such as your device intenet protocol ("IP")address , device name ,oprating system verios,etc. ) for any purpuse as below',
            ),
            _buildRichText(
              'Retention.',
              'WE will retain usage data for internal analysis purposes. usage data is genarally retained of a shorter period of time, exept when this data is used to strengthen the security or to improve the functionality of our service , or we are legally obligated to retain this data for longer time periods.',
            ),
            _buildRichText(
              'Security.',
              'We use administrative, technical, and physical security measures to help protect your personal data. the security of your personal data is importent to Us, but remember that no methord of transmition over the internet or methord of electronic storage is 100% secure. while we strive to use commercially accepteble means to protect your personal data , we connot guarentee its absolute security.',
            ),
            _buildRichText(
              'Changes to this privacy and policy.',
              'we may update our privacy and policy from time to time. thuse your advised to review this page pereadically for any changes . we will notify you of any changes by posting the new privacy policy on this page . thes change are effective immediatily after they are posted on this page.',
            ),
            _buildRichText(
              'Contact Us.',
              'if you want further information about our pryvacy policy and what iy means. please feel free to email us at support ',
              'ajilesh46@gmail.com',
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, FontWeight fontWeight, double fontSize, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 30),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }

  Widget _buildRichText(String title, String content, [String? email = null]) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 30),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: '$title '),
            TextSpan(
              text: content,
              style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
            ),
            if (email != null) TextSpan(text: email, style: const TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
