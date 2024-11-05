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
            apiKey: "AIzaSyC1h6rWYeSi-9oT7apAZoJWMvMpOGEpSi4",
  authDomain: "reddrop1-f1c8c.firebaseapp.com",
  projectId: "reddrop1-f1c8c",
  storageBucket: "reddrop1-f1c8c.appspot.com",
  messagingSenderId: "765692546365",
  appId: "1:765692546365:web:8253f61fbbdaf02a2a8954",
  measurementId: "G-ZKG1XFP8DP"
            ),
      );
    } else if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyC1h6rWYeSi-9oT7apAZoJWMvMpOGEpSi4",
          appId: "1:765692546365:android:4e69d89b94859dd62a8954",
          messagingSenderId: "765692546365",
          projectId: "reddrop1-f1c8c",
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
