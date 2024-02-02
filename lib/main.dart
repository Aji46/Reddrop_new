import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reddrop/Home/home_Page/box.dart';
import 'package:reddrop/Home/home_Page/contactdatabase.dart';
import 'package:reddrop/splash/splash.dart';



const SAVE_KEY_NAME ="userLoggedin";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactdbAdapter());
  boxcontact =await Hive.openBox<Contactdb>('contactbox');
  
  try {
    Platform.isAndroid
        ? await Firebase.initializeApp(
            options: const FirebaseOptions(
              apiKey: "AIzaSyAJ5kY8MUv2TAjqnZdH5vWW2TIQ2mvJu8E",
              appId: "1:175166379388:android:4a5f1d3ff602f47dabc0f9",
              messagingSenderId: "175166379388",
              projectId: "reddrop1-93fb0",
            ),
          )
        : await Firebase.initializeApp();
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: 'phone',
      debugShowCheckedModeBanner: false,
      // routes: {
      //   'phone': (context) => MyPhone(),
      //   'verify': (context) => MyVerify(verificationId: '',)
      // },
      theme: ThemeData(
        textTheme: const TextTheme(),
      ),
      home: const Splash(),
    );
  }
}
