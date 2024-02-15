import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reddrop/Home/home_Page/box.dart';
import 'package:reddrop/Home/home_Page/contactdatabase.dart';
import 'package:reddrop/splash/splash.dart';

const SAVE_KEY_NAME ="userLoggedin";
const bool kIsWeb = identical(0, 0.0);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactdbAdapter());
  boxcontact = await Hive.openBox<Contactdb>('contactbox');
  
try {
  if (kIsWeb) { 
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA44mKuX-mq2l_MiJbB8Ag6BDNY1P_Nl-o",
        authDomain: "reddrop1-93fb0.firebaseapp.com",
        databaseURL: "https://reddrop1-93fb0-default-rtdb.firebaseio.com",
        projectId: "reddrop1-93fb0",
        storageBucket: "reddrop1-93fb0.appspot.com",
        messagingSenderId: "175166379388",
        appId: "1:175166379388:web:20278cf7d5d17792abc0f9",
        measurementId: "G-QBJXK2QNCG"
      ),
    );
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAJ5kY8MUv2TAjqnZdH5vWW2TIQ2mvJu8E",
        appId: "1:175166379388:android:4a5f1d3ff602f47dabc0f9",
        messagingSenderId: "175166379388",
        projectId: "reddrop1-93fb0",
      ),
    );
  }
} catch (e) {
  print("Error initializing Firebase: $e");
}


  // Set preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
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
