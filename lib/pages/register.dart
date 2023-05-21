import 'package:b_help/pages/homepage.dart';
import 'package:b_help/pages/phoneauth_ui.dart';
import 'package:b_help/services/googleauth.dart';
import 'package:flutter/material.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/pharmacy.png',height: 250.0),
            SizedBox(height: 20.0),
            Text('slogan slogan slogan',style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 60.0),
            GestureDetector(
              onTap: () async {
                await GoogleAuthservices().signInwithGoogle();
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneAuth()));
              },
              child: Container(
                width: 350.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.0),
                  color: Colors.grey[900],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Register using Gmail',style: TextStyle(
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
    );
  }
}
