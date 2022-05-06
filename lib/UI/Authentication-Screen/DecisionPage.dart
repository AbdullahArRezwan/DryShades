import 'package:dry_shades/UI/Authentication-Screen/Sign_inScreen.dart';
import 'package:dry_shades/UI/Authentication-Screen/WelcomeScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Main_Screen/Screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DecisionPage extends StatelessWidget {
  DecisionPage({Key? key}) : super(key: key);

  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if(value == null){
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.data == false){
          return WelcomeScreen();
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Container(
            color: kBackGroundColor,
            child: Center(
              child: CircularProgressIndicator(color: kMainColor,),
            ),
          );
        }
        return Screens();
      },
    );;
  }
}
