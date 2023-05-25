import 'package:b_help/pages/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/googleauth.dart';

class DonateInterface extends StatefulWidget {
  const DonateInterface({Key? key}) : super(key: key);

  @override
  State<DonateInterface> createState() => _DonateInterfaceState();
}

class _DonateInterfaceState extends State<DonateInterface> {

  String finalName = ' ';
  String finalNumber = " ";

  void readText() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String username = sp.getString("username").toString();
    String userNumber = sp.getString("number").toString();
    setState(() {
      finalName = username;
      finalNumber = userNumber;
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    readText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              finalName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                GoogleAuthservices().SignOutwithGoogle();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => registerPage()));
              },
              icon: Icon(
                Icons.logout,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              alignment: Alignment.center,
              child: Text('Thank you for registering. we have stored the data that you'
                  ' have entered in our database. the phone number that you have entered will be visible'
                  ' to the person who is in need of blood and can contact you through our app ',style: TextStyle(
                fontSize: 24.0
              ),),
            ),
          )
        ),
      ),
    );
  }
}
