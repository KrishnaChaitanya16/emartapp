import 'package:emartapp/cartprovider.dart';
import 'package:emartapp/pages/Loginpage.dart';
import 'package:emartapp/pages/splashscreen.dart';
import 'package:emartapp/whishlistprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCb6fetsjoPyJJ0KWzGqIdBBYajeyifdVU",
        appId: 'com.example.emartapp',
        messagingSenderId: 'messagingSenderId',
        projectId: 'emartapp-15b22',
        storageBucket: 'emartapp-15b22.appspot.com',   ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
         shadowColor: Colors.grey.shade300,

          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10), // Adjust the radius as needed
            ),
          ),



        )
      ),
    );
  }
}