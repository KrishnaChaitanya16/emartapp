import 'package:emartapp/pages/Loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCb6fetsjoPyJJ0KWzGqIdBBYajeyifdVU",
        appId: 'com.example.emartapp',
        messagingSenderId: 'messagingSenderId',
        projectId: 'emartapp-15b22',
        storageBucket: 'emartapp-15b22.appspot.com',   ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,

      home: Loginpage(),
    );
  }
}

