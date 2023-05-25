import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:b_help/pages/donate_interface.dart';
import 'package:b_help/pages/homepage.dart';
import 'package:b_help/pages/location.dart';
import 'package:b_help/pages/need_interface.dart';
import 'package:b_help/pages/otp_verification.dart';
import 'package:b_help/pages/phoneauth_ui.dart';
import 'package:b_help/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Lottie.network('https://assets6.lottiefiles.com/datafiles/jxW74X4pnGU6PL5/data.json'),
        backgroundColor: Colors.white,
        duration: 3000,
        splashIconSize: 250,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: (FirebaseAuth.instance.currentUser != null) ? HomePage() : registerPage(),
        pageTransitionType: PageTransitionType.leftToRightWithFade,
      ),
    );
  }
}
