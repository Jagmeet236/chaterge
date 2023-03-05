import 'package:chat_app/Authentication/Firebase_functions.dart';
import 'package:chat_app/Authentication/LogIn_screen.dart';
import 'package:chat_app/view/Home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animation/animation_screen.dart';
import '../animation/page-transition_screen.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "Welcome To Chaterge...",
          style: GoogleFonts.actor(
              fontSize: 25, fontWeight: FontWeight.w500, letterSpacing: 1
              // fontStyle: FontStyle.italic,
              ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  SlideTopRoute(
                    builder: (context) => const loginscreen(),
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.back)),
        ],
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : ListView(physics: BouncingScrollPhysics(), children: [
              Column(
                children: [
                  SizedBox(
                    height: size.height / 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                        width: size.width / 1,
                        // height: size.height/4,
                        child: ImageSlideAnimation(
                          assetName: 'images/chat.png',
                          height: size.height / 4,
                        )),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Create An Account to Contiue!",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.1),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Name", Icons.account_box, name),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "email", Icons.account_box, email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "password", Icons.lock, password),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 300,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: const Divider(
                      color: Colors.grey,
                      height: 10.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        SlideTopRoute(
                          builder: (context) => const loginscreen(),
                        ),
                      ),
                      child: Text(
                        "Have An Account?",
                        style: GoogleFonts.actor(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (name.text.isNotEmpty &&
            email.text.isNotEmpty &&
            password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          createAccount(name.text, email.text, password.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              Navigator.pushReplacement(
                context,
                FadePageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ).whenComplete(() => password.clear());
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please enter Fields");
        }
      },
      child: Card(
        elevation: 1,
        child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white54,
          ),
          alignment: Alignment.center,
          child: const Text(
            "Create Account",
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 1.4,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
