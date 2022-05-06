import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Main_Screen/Screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifiedScreen extends StatelessWidget {
  const VerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Padding(padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h),
          child: Stack(
            alignment: Alignment.center,
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
              Padding(padding: EdgeInsets.only(
                top: 230.h,
                // bottom: 240,
                left: 10.w,
                right: 10.w,
              ),
              child: Container(
                height: 350.h,
                decoration: BoxDecoration(
                  color: Color(0xff072A6C),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Padding(padding: EdgeInsets.only(
                  top: 30.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 60.w,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text("Verified!",
                      // style: GoogleFonts.zenKurenaido( //supermercadoOne
                      //   fontStyle: FontStyle.italic,
                      //   decoration: TextDecoration.none,
                      //   fontSize: 50.sp,
                      //   fontWeight: FontWeight.w900,
                      //   color: Colors.white,
                      // ),
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.normal
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text("Wow! You have successfully verified your account.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.zenKurenaido( //supermercadoOne
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            _buildScreen(),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff072A6C)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.r),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.w),
                          child: Text(
                            'Go to Dashboard',
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

PageRouteBuilder _buildScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Screens();
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1),
  );
}
