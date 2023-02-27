import 'dart:async';
import 'package:chat_app/Authentication/LogIn_screen.dart';
import 'package:flutter/material.dart';

import 'liquid_transtion.dart';



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
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    )..addListener(() {
      setState(() {});
    });
    _controller.forward();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        FadePageRoute(
          builder: (context) => loginscreen(),
        ),
      );

    });
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
          child: Container(

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.3),
              //     blurRadius: 10,
              //     spreadRadius: 5,
              //   ),
              // ],
            ),
            padding: EdgeInsets.all(20),



    child: Image.asset('assets/logo.png',scale: 1,),),

          )));
  }
}
