

import 'package:chat_app/Authentication/Firebase_functions.dart';
import 'package:chat_app/Authentication/SignUp_screen.dart';
import 'package:chat_app/view/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../animation/animation_screen.dart';
import '../animation/page-transition_screen.dart';


class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
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
        title: const Text(
          "Welcome To Chaterge...",
          style: TextStyle(

              letterSpacing: 1, fontSize: 25, fontWeight: FontWeight.w400),
        ),
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),


                        child: Container(
                          width:size.width/1,
                            // height: size.height/4,
                            child:ImageSlideAnimation(
                              assetName:'images/chat.png',
                              height: size.height/4,
                            )
                        ),
                      ),



                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Sign In ",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
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
                    height: size.height / 50,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 50,
                  ),
                 const Text("OR"),
                  SizedBox(height: size.height/50,),
                  Container(
                    height: 40,
                    child: Center(

                      child: FloatingActionButton.extended (
                        elevation: 1,
                          onPressed: ()
                      {


                      },
                          backgroundColor: Colors.white,

                          // icon: Icon(Icons.add),
                          label:const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                CircleAvatar(radius: 20, backgroundColor:Colors.white,child: Image(height: 20,
                                  image: AssetImage('images/google.png'),)),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0,top: 12),
                                  child: Text('Google Sign In',style: TextStyle(color: Colors.grey,letterSpacing: 1.5),),
                                )
                              ]
                          )
                      ),


                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: size.width/1.1,
                    child: const Divider(
                      color: Colors.grey,
                      height: 10.0,

                    ),
                  ),

                  SizedBox(height: size.height/60,),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      SlideTopRoute(
                        builder: (context) => signup(),
                      ),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child:
                          Text(
                            "Create An Account?",
                            style: GoogleFonts.actor(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              // fontStyle: FontStyle.italic,
                            ),

                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (email.text.isNotEmpty && password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(email.text, password.text).then((user) {
            if (user != null) {
              print("Login Sucessfull");
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
          print("Please fill form correctly");
        }
      },
      child: Card(
        elevation: 1,
        child: Container(
            height: size.height / 14,
            width: size.width / 1.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white54,
            ),
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 18,
fontFamily: 'Roboto',
                  letterSpacing: 1.4),
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
