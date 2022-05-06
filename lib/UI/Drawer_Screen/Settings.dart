import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Color(0xff072A6C),
        ),
        title: Text("Settings",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.w900,
            color: Color(0xff072A6C),
          ),
        ),
      ),
    );
  }
}
