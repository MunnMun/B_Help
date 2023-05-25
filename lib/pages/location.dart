import 'dart:ffi';

import 'package:b_help/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Location extends StatefulWidget {
  final String? phoneNumber;
  const Location({Key? key,required this.phoneNumber}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {

  String? valueChoose;
  String? latitude;
  String? longitude;
  String? name;
  List listItem = [
    "A+","A-","B+","B-","AB+","AB-","O+","O-"
  ];
  bool agree = false;

  @override
  Widget build(BuildContext context) {

    void getCurrentPosition() async {
      LocationPermission  permission = await Geolocator.checkPermission();

      if(permission==LocationPermission.denied || permission==LocationPermission.deniedForever){
        LocationPermission asked = await Geolocator.requestPermission();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please give permission to proceed furthur')));
      } else{
        Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        latitude = currentPosition.latitude.toString();
        longitude = currentPosition.longitude.toString();

        Map<String,dynamic> newUserData = {
          "blood group": valueChoose,
          "latitude": latitude,
          "longitude": longitude,
          "name": name,
          "phone number": widget.phoneNumber!.substring(3),
        };

        await FirebaseFirestore.instance.collection("users").add(newUserData);
      }
    }


    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 30.0),
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                        Text('User Details',style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),),
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                title: Text("Terms and conditions",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0
                                ),),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("1) You are aged between 18 and 65.",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                    Text("2) You weigh at least 50 kg.",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                    Text("3) You cannot donate if you have a cold, flu, sore throat, cold sore, stomach bug or any other infection",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                    Text("If you have recently had a tattoo or body piercing you cannot donate for 6 months from the date of the procedure",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                    Text("If you engaged in “at risk” sexual activity in the past 12 months",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                    SizedBox(height: 10.0),
                                    Text("**Individuals with behaviours below will be deferred permanently: ",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                    Text(" - Have ever had a positive test for HIV (AIDS virus)",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                    Text(" - Have ever injected recreational drugs.",style: TextStyle(
                                        fontSize: 18.0
                                    ),),
                                  ],
                                ),
                                actions: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: TextButton(
                                        onPressed: (){
                                          agree = true;
                                          Navigator.pop(context);
                                        },
                                        child: Text('I Agree',style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold
                                        ),)
                                    ),
                                  ),
                                ],
                              );
                            }
                        );
                      },
                      child: Container(
                        width: 140,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text('T&C',style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Text('Please select',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),),
                     SizedBox(height: 5.0),
                     Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 1),
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white
                        ),
                        child: DropdownButton(
                          hint: Text('Your Blood Group'),
                            icon: Icon(Icons.arrow_drop_down,color: Colors.black),
                            iconSize: 36,
                            underline: SizedBox(),
                            isExpanded: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0
                            ),
                            value: valueChoose,
                          onChanged: (newValue){
                              setState(() {
                                valueChoose = newValue.toString();
                              });
                          },
                          items: listItem.map((valueItem){
                            return DropdownMenuItem(
                                value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList()
                        ),
                      ),
                    SizedBox(height: 25.0),
                    Text('please enter ',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 5.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.black,width: 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          onChanged: (val){
                            setState(() {
                              name = val.toString();
                            });
                          },
                          maxLength: 20,
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                              hintText: 'Your Name'
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Text('Phone number',style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: 5.0),
                    Text(widget.phoneNumber!.substring(3),style: TextStyle(
                        fontSize: 24.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      color: Colors.grey[700]
                    ),),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () async{
                        if(agree != true){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kindly read T&C and agree to them')));
                        }
                        if(name==null || valueChoose==null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please fill all the fields')));
                        }
                        if(name!=null && valueChoose!=null && agree==true){
                          getCurrentPosition();
                          SharedPreferences sp = await SharedPreferences.getInstance();
                          sp.setString("username", name!);
                          sp.setString("number", widget.phoneNumber!.substring(3));
                          print(sp.get("username"));
                          print(sp.get("number"));
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: Colors.grey,width: 2),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text('Share Location',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
