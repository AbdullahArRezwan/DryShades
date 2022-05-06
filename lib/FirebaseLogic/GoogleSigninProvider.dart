import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogIn() async{
    try {
      final googleUser = await googleSignIn.signIn();
      if(googleUser == null) return;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // final currentUser = FirebaseAuth.instance.currentUser!;
      //     await FirebaseFirestore.instance
      //         .collection('UserData')
      //         .doc(userCredential.user!.uid)
      //         .set({
      //       "FullName": currentUser.displayName,
      //       "Email": currentUser.email,
      //       "PhoneNumber": "Phone",
      //       "Password": "Hello@123",
      //       "Address": "Address",
      //       "ImageUrl": currentUser.photoURL,
      //     });
    } catch(e){
      print(e.toString());
    }
    notifyListeners();
  }

  Future logOut() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}