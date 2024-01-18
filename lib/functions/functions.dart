import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneUtils {
  static void makeCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



   static void shareContact(String contactDetails) async{
    Share.share(contactDetails, subject: 'Contact Information');
  }

}


