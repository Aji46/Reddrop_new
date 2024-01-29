import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share/share.dart';

class PhoneUtils {
  // static void makeCall(String phoneNumber) async {
  //   final url = 'tel:$phoneNumber';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

static void makeCall(String phoneNumber) async {
  final number = 'tel:$phoneNumber'; // set the number here
   bool? result = await FlutterPhoneDirectCaller.callNumber(number);

  // Check if the result is not null before assigning it to a bool variable
  if (result != null) {
    bool res = result;
    // Now you can use 'res' as a non-nullable boolean
    // ... rest of your code
  } else {
    // Handle the case when the result is null (optional)
    print("Call failed or was cancelled.");
  }
}


   static void shareContact(String contactDetails) async{
    Share.share(contactDetails, subject: 'Contact Information');
  }

}


