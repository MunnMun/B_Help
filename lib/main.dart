import 'package:b_help/pages/donate_interface.dart';
import 'package:b_help/pages/homepage.dart';
import 'package:b_help/pages/location.dart';
import 'package:b_help/pages/otp_verification.dart';
import 'package:b_help/pages/phoneauth_ui.dart';
import 'package:b_help/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
      home: (FirebaseAuth.instance.currentUser != null) ? HomePage() : registerPage(),
    );
  }
}
