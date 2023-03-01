import 'package:chat_app/view/splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
late Size mq;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chaterge",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
         titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontSize: 16),
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        )
      ),
      home: SplashScreen(),
    );
  }
}
