import 'dart:async';

import 'package:dry_shades/UI/Authentication-Screen/EmailUserForm.dart';
import 'package:dry_shades/UI/Authentication-Screen/Sign_inScreen.dart';
import 'package:dry_shades/UI/Authentication-Screen/VerifiedScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
//rezu 01

class EmailVerification extends StatefulWidget {
  String email;
  EmailVerification({Key? key, required this.email}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState(email);
}

class _EmailVerificationState extends State<EmailVerification> {
  late String email;
  _EmailVerificationState(this.email);
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (isEmailVerified)
      return EmailUserForm(email: widget.email);
    else
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackGroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.w,
              horizontal: 12.w,
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/top.png",
                    width: size.width * 0.2,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/bottom.png",
                    width: size.width * 0.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back,
                            size: 32.w,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.asset(
                              'assets/images/OTP 1.jpg',
                            ),
                          )),
                      Text(
                        "Verify your email address",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.zenKurenaido(
                          //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w900,
                          color: kMainColor,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "A verification link has been sent to your mail:",
                        style: GoogleFonts.zenKurenaido(
                          //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        email,
                        style: GoogleFonts.zenKurenaido(
                          //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff072A6C),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: SizedBox(
                          width: double.infinity,
                          height: 57.h,
                          child: ElevatedButton(
                            onPressed: !canResendEmail ? sendVerificationEmail : null,
                            style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.lightBlue),
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(14.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Colors.white,
                                      size: 24.w,
                                    ),
                                    SizedBox(width: 15.w),
                                    Text(
                                      'Resent Email',
                                      style: TextStyle(fontSize: 22.sp),
                                    ),
                                  ],
                                )
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(30.h)),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut().then((value)=>Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Sign_inScreen())));
                          },
                          child: Text("Cancel",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.lightBlue,
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}