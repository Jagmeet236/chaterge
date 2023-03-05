import 'dart:io';

import 'package:chat_app/Authentication/LogIn_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/dialog.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

Future<User?> createAccount(String name, String email, String password) async {
  try {
    UserCredential userCrendetial = await auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .whenComplete(() => Dialogs.showToast('Account Created Sucessfully'));

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "uid": auth.currentUser!.uid,
      "status": "unavalible"
    }).whenComplete(() => Dialogs.showToast('Welcome $name'));

    return userCrendetial.user;
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
  } catch (e) {
    Dialogs.showToast('An error occurred: $e');
  }
  return null;
}

Future<User?> logIn(String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  try {
    await auth.signOut().then((value) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const loginscreen()));
    });
  } catch (e) {
    print("error");
  }
}

class FirebaseServices {
  Future<DocumentSnapshot> getUserDetails(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").doc(auth.currentUser!.uid).get();
    return doc;
  }

  Future<DocumentSnapshot> getuserId(id) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").doc(auth.currentUser!.uid).get();
    return doc;
  }
}
