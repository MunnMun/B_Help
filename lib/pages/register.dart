import 'package:b_help/pages/homepage.dart';
import 'package:b_help/pages/phoneauth_ui.dart';
import 'package:b_help/services/googleauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/blood-drop.png',height: 250.0),
              SizedBox(height: 30.0),
              Text('Help save a life',style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold
              ),),
              Text('Donate blood today',style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 65.0),
              GestureDetector(
                onTap: () async {
                  await GoogleAuthservices().signInwithGoogle();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(context ,MaterialPageRoute(builder: (context) => PhoneAuth()));
                },
                child: Container(
                  width: 350.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey[900],
                    border: Border.all(color: Colors.grey,width: 2.0)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Register Gmail',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),),
                        Image.asset('assets/google.png'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
