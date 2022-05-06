import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Utils{
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text){
    if(text == null) return;
    final snackBar = SnackBar(content: Text(text, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.lightBlue,
      duration: Duration(seconds: 3),
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}