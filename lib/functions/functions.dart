import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share/share.dart';


class PhoneUtils {


static void makeCall(String phoneNumber) async {
  final number = 'tel:$phoneNumber'; // set the number here
   bool? result = await FlutterPhoneDirectCaller.callNumber(number);

  // Check if the result is not null before assigning it to a bool variable
  if (result != null) {
  
    // ... rest of your code
  } else {
    // Handle the case when the result is null (optional)
  }
}


   static void shareContact(String contactDetails) async{
    Share.share(contactDetails, subject: 'Contact Information');
  }

}




