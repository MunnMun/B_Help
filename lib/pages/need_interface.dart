// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:b_help/pages/register.dart';
import 'package:b_help/services/googleauth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedInterface extends StatefulWidget {
  const NeedInterface({Key? key}) : super(key: key);

  @override
  State<NeedInterface> createState() => _NeedInterfaceState();
}

class _NeedInterfaceState extends State<NeedInterface> {
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

  List listItem = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  String? valueChoose;
  List<Map<String, dynamic>> userData = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: width,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      finalName!,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: IconButton(
                        onPressed: () {
                          GoogleAuthservices().SignOutwithGoogle();
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => registerPage()));
                        },
                        icon: Icon(
                          Icons.logout,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black,width: 2),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: 150,
                        child: DropdownButton(
                            hint: Text('Blood Group'),
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36,
                            underline: SizedBox(),
                            isExpanded: true,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0),
                            value: valueChoose,
                            onChanged: (newValue) {
                              setState(() {
                                valueChoose = newValue.toString();
                              });
                            },
                            items: listItem.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList()),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("phone number", isNotEqualTo: finalNumber)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> userMap =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;

                                double distance = Geolocator.distanceBetween(
                                    28.59,
                                    77.0,
                                    double.parse(userMap['latitude']),
                                    double.parse(userMap['longitude']));
                                userMap['distance'] = (distance / 1000).toStringAsFixed(2);
                                return valueChoose == userMap['blood group']
                                    ? PersonContainer(
                                        name: userMap['name'],
                                        blood: userMap['blood group'],
                                        distance: userMap['distance'],
                                        phone: userMap['phone number'])
                                    : Container();
                              }),
                        );
                      } else {
                        return Text('no data');
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonContainer extends StatelessWidget {
  final String name;
  final String blood;
  final String distance;
  final String phone;
  const PersonContainer({
    Key? key,
    required this.name,
    required this.blood,
    required this.distance,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void launchCallLog(String phone) async {
      Uri phoneno = Uri.parse('tel:$phone');
      if (await launchUrl(phoneno)) {
        print("okay");
      } else {
        print("not okay");
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    blood,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                distance + "KM Away",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          Ink(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(40),
            ),
            child: GestureDetector(
              onTap: () {
                launchCallLog(phone);
              },
              child: Icon(
                Icons.call,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
