import 'package:b_help/pages/homepage.dart';
import 'package:b_help/pages/location.dart';
import 'package:b_help/pages/phoneauth_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerify extends StatefulWidget {
  final String verificationId;
  const OtpVerify({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  TextEditingController otpController = TextEditingController();

  void verifyOTP() async {
    String otp = otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: otp);

    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if(userCredential.user!=null){
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Location(phoneNumber: userCredential.user!.phoneNumber,)));
      }
    } on FirebaseAuthException catch (ex){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ex.code.toString())));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuth()));
              },
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 30.0),
          )
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 30.0),
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/check-mark.png',height: 140.0),
                    SizedBox(height: 30.0),
                    Text('Phone Verification',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),),
                    SizedBox(height: 4.0),
                    Text('OTP',style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[500],
                    ),),
                    SizedBox(height: 30.0),
                    PinCodeTextField(
                        appContext: context,
                        controller: otpController,
                        length: 6,
                        enableActiveFill: true,
                        cursorHeight: 20.0,
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldWidth: 35.0,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey[400],
                          selectedColor: Colors.grey[400],
                          activeFillColor: Colors.grey[400],
                          selectedFillColor: Colors.grey[400],
                          inactiveFillColor: Colors.grey.shade100,
                          borderWidth: 1.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onChanged: ((value) {}),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: (){
                        verifyOTP();
                      },
                      child: Container(
                        height: 70.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text('Verify Phone Number',style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneAuth()));
                          },
                          child: Text('Edit Phone Number?',style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            color: Colors.grey[700]
                          ),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
