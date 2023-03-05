import 'dart:async';
import 'package:chat_app/Authentication/LogIn_screen.dart';
import 'package:chat_app/view/Home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animation/page-transition_screen.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {


    Timer(const Duration(seconds: 5), (){

    // TODO: implement initState
    Timer(Duration(seconds: 5), (){

      FirebaseAuth.instance.authStateChanges().listen((user) async
      {
        if (user == null) {
          Navigator.pushAndRemoveUntil(

              context, MaterialPageRoute(builder: (_) => const loginscreen()), (

              context, MaterialPageRoute(builder: (_) => loginscreen()), (

              route) => false);

        }
        else
        {
          Navigator.pushAndRemoveUntil(

              context, MaterialPageRoute(builder: (_) => const HomeScreen()), (

              context, MaterialPageRoute(builder: (_) => HomeScreen()), (

              route) => false);

        }
      });
    }
    );
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    )..addListener(() {
      setState(() {});
    });
    _controller.forward();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        FadePageRoute(
          builder: (context) => const loginscreen(),
        ),
      );

    });

    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),

                ),
                padding: const EdgeInsets.all(20),



            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),

            ),
            padding: EdgeInsets.all(20),



    child: Image.asset('images/chat.png'),),
              SizedBox(height:15 ,),
             Text(
                "Chaterge",
                style: GoogleFonts.acme(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),



    child: Image.asset('images/chat.png'),),


          )));
  }
}
