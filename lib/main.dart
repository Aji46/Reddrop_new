import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reddrop/contact/box.dart';
import 'package:reddrop/contact/contactdatabase.dart';
import 'package:reddrop/splash/splash.dart';

const SAVE_KEY_NAME = "userLoggedin";
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
            measurementId: "G-QBJXK2QNCG"),
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

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  assert(binding.debugCheckZone('runApp'));
  binding
    // ignore: invalid_use_of_protected_member
    ..scheduleAttachRootWidget(binding.wrapWithDefaultView(const MyApp()))
    ..scheduleWarmUpFrame();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'phone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(),
      ),
      home: const Splash(),
    );
  }
}
