import 'package:b_help/pages/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
          "username": name,
          "phone number": widget.phoneNumber,
        };

        await FirebaseFirestore.instance.collection("users").add(newUserData);
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('User Details',style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            barrierDismissible: false,
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: Text("Conditions",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0
                                  ),),
                                  content: Text("dhgdsghdghsdghsdgdsghsdghsdghsghdsghdghghdssghddsghsdghhsgd",style: TextStyle(
                                    fontSize: 18.0
                                  ),),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text('I Agree',style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold
                                        ),)
                                    ),
                                  ],
                                );
                              }
                          );
                        },
                        child: Container(
                          width: 130,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text('Conditions',style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 40.0),
                  Text('Please select',style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),),
                   SizedBox(height: 10.0),
                   Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1),
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white
                      ),
                      child: DropdownButton(
                        hint: Text('Your Blood Group'),
                          icon: Icon(Icons.arrow_drop_down),
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
                  SizedBox(height: 40.0),
                  Text('please enter -',style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: Colors.grey,width: 1.0),
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
                  SizedBox(height: 40.0),
                  Text('your Phone number',style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10.0),
                  Text(widget.phoneNumber!,style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: (){
                      if(name==null || valueChoose==null){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please fill all the fields')));
                      }
                      if(name!=null && valueChoose!=null){
                        getCurrentPosition();
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.white,width: 2),
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
    );
  }
}
