import 'package:chat_app/Authentication/Firebase_functions.dart';
import 'package:chat_app/widgets/chat_user_card.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userMap;

  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home Screen'),
          leading: const Icon(CupertinoIcons.home),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
            IconButton(
                onPressed: () {
                  logOut(context);
                },
                icon: const Icon(CupertinoIcons.ellipsis_vertical)),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              CupertinoIcons.add_circled_solid,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 16,
              itemBuilder: (context, index) {
                return const ChatUserCard();
              }),
        ));
  }
}
