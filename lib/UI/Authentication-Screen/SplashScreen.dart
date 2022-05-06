import 'dart:async';
import 'package:dry_shades/UI/Authentication-Screen/DecisionPage.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3),()=>Navigator.push(context, CupertinoPageRoute(builder: (_) => DecisionPage())));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "DryShades",
                style: GoogleFonts.zenKurenaido( //supermercadoOne
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.none,
                  fontSize: 70.sp,
                  fontWeight: FontWeight.w900,
                  color: kMainColor,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CircularProgressIndicator(
                color: kMainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
