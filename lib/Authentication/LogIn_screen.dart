import 'dart:io';

import 'package:chat_app/Authentication/Firebase_functions.dart';
import 'package:chat_app/Authentication/SignUp_screen.dart';
import 'package:chat_app/utils/dialog.dart';
import 'package:chat_app/view/Home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        title: Text(
          "Welcome To Chaterge...",
          style: GoogleFonts.actor(
              fontSize: 25, fontWeight: FontWeight.w500, letterSpacing: 1
              // fontStyle: FontStyle.italic,
              ),
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
          : ListView(physics: BouncingScrollPhysics(), children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                        width: size.width / 1,
                        // height: size.height/4,
                        child: ImageSlideAnimation(
                          assetName: 'images/chat.png',
                          height: size.height / 4,
                        )),
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
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: FloatingActionButton.extended(
                          elevation: 1,
                          onPressed: () {
                            Dialogs.showProgressBar(context);
                            loginWithGoogle(context).then(
                              (value) => Navigator.pop(context),
                            );
                          },
                          backgroundColor: Colors.white,

                          // icon: Icon(Icons.add),
                          label: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Image(
                                      height: 20,
                                      image: AssetImage('images/google.png'),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 12.0, top: 12),
                                  child: Text(
                                    'Google Sign In',
                                    style: TextStyle(
                                        color: Colors.grey, letterSpacing: 1.5),
                                  ),
                                )
                              ])),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: const Divider(
                      color: Colors.grey,
                      height: 10.0,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 60,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      SlideTopRoute(
                        builder: (context) => signup(),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
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
            ]),
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
                color: Colors.grey.shade700, fontSize: 18, letterSpacing: 1.4),
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

Future loginWithGoogle(context) async {
  FirebaseServices services = FirebaseServices();
  FirebaseAuth _auth = FirebaseAuth.instance;

  final googleSignIn = GoogleSignIn(scopes: ['email']);
  try {
    await InternetAddress.lookup('google.com');
    final googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return false;
    }
    final googleSignInAuthentication = await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => {
              if (value != null)
                {
                  services.getuserId(value.user!.uid).then((snapshot) async => {
                        if (snapshot.exists)
                          {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()),
                                (route) => false),
                          }
                        else
                          {
                            _createUser(
                              googleSignInAccount.email,
                              value.user!.uid,
                              googleSignInAccount.displayName,
                            ),
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => const HomeScreen()),
                                (route) => false),
                          }
                      })
                }
            });
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        Dialogs.showSnackBar(context, 'Account Already exist');
        break;
      case 'invalid-credential':
        Dialogs.showSnackBar(context, 'Unknown error has occurred');
        break;
      case 'Internet Connection':
        Dialogs.showSnackBar(context,
            "Something went wrong please check your internet connection");
        break;
      case 'user-disabled':
        Dialogs.showSnackBar(
            context, 'The user you tried to log into is disabled');
        break;
      case 'user-not-found':
        Dialogs.showSnackBar(
            context, 'The user you tried to log into is not found');
        break;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Log in with google failed'),
              content: Text(
                'Log in with google failed',
                style: GoogleFonts.acme(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // fontStyle: FontStyle.italic,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  }
}

void _createUser(
  email,
  uid,
  name,
) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set({
      "name": name,
      "email": email,
      "uid": _auth.currentUser!.uid,
      "status": "unavalible"
    }).whenComplete(() => Dialogs.showToast('Welcome ' + name));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Dialogs.showToast('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      Dialogs.showToast('The account already exists for that email.');
    } else {
      Dialogs.showToast('An error occurred: ${e.message}');
    }
  } on SocketException catch (e) {
    Dialogs.showToast('No internet connection available');
  }
}
