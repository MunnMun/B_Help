import 'package:b_help/pages/donate_interface.dart';
import 'package:b_help/pages/need_interface.dart';
import 'package:b_help/pages/register.dart';
import 'package:b_help/services/googleauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NeedInterface()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.white,width: 1),
                  ),
                  child: Center(
                      child: Text('Need Blood',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),)
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DonateInterface()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.white,width: 1),
                  ),
                  child: Center(
                      child: Text('Donate Blood',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
