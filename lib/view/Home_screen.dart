import 'package:chat_app/Authentication/Firebase_functions.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key );

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
        title: Text('HomeScreen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            logOut(context);
          }, icon: Icon(Icons.arrow_back)),
        ],
        backgroundColor: Colors.black,
      ),
      body:isLoading
          ? Center(
        child: Container(
          height: 50,
            width:120 ,
          child:Container(child: Center(child: Text("no user found")),),
        ),
      )
          : Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 5,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          ElevatedButton(
            style:ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.black),),

            onPressed: onSearch,
            child: Text("Submit"),

          ),
          SizedBox(
            height: size.height / 30,
          ),
          userMap != null
              ? ListTile(
            onTap: () {

            },
            leading: Icon(Icons.account_box, color: Colors.black),
            title: Text(
              userMap!['name'],
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(userMap!['email']),
            trailing: Icon(Icons.chat, color: Colors.black),
          )
              : Container(),

          // TextButton(onPressed: (){
          //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home_screen()));}, child:Text("click me"))
        ],
      ),


    );
  }
}
