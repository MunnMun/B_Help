import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleAuthservices{
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInwithGoogle() async {
    try{
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();

      if(GoogleSignInAccount!=null){
        final GoogleSignInAuthentication gAuth = await gUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        await _auth.signInWithCredential(credential);

      }

    }on FirebaseAuthException catch (ex){
      print(ex.code.toString());
    }
  }

  SignOutwithGoogle() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

