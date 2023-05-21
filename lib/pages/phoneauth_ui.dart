import 'dart:ffi';

import 'package:b_help/pages/otp_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();

  void sendOTP() async {
    String phone = "+91"+phoneController.text.trim();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (verificationId,resendToken) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerify(verificationId: verificationId)));
      },
      verificationCompleted: (credential) {},
      verificationFailed: (ex){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
      timeout: Duration(seconds: 30),
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/phone-call.png',height: 120.0),
                    SizedBox(height: 30.0),
                    Text('Phone Verification',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),),
                    SizedBox(height: 4.0),
                    Text('Please enter your phone number',style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[500],
                    ),),
                    SizedBox(height: 10.0),
                    Container(
                      height: 55.0,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0,color: Colors.grey.shade700),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('+ 91',style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(width: 10.0),
                            Text(' | ',style: TextStyle(
                              fontSize: 33.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                            ),),
                            SizedBox(width: 10.0),
                            Expanded(
                                child: TextField(
                                  controller: phoneController,
                                  maxLength: 10,
                                  style: TextStyle(
                                    letterSpacing: 5.0,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintText: 'Phone Number'
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: (){
                        sendOTP();
                      },
                      child: Container(
                        height: 70.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text('Send OTP',style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ),
        )
    );
  }
}
