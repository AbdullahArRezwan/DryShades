import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/FirebaseLogic/GoogleSigninProvider.dart';
import 'package:dry_shades/UI/Authentication-Screen/GoogleUserForm.dart';
import 'package:dry_shades/UI/Authentication-Screen/PhoneUserForm.dart';
import 'package:dry_shades/UI/Authentication-Screen/Sign_inScreen.dart';
import 'package:dry_shades/UI/Authentication-Screen/Sign_upScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Social_Buttons.dart';
import 'package:dry_shades/UI/Main_Screen/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//rezu 01

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  welcomeScreen() {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Hero(
            tag: 'image',
            child: Image.asset(
              'assets/images/welcomeOne.jpg',
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: 'text',
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    'Welcome',
                    style: GoogleFonts.zenKurenaido(
                      //sacramento
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w900,
                      fontSize: 44.sp,
                      color: kMainColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                // padding: EdgeInsets.all(10),
                child: Text(
                  "If you’re looking to move house, and want to find a suitable rental property or shared accommodation, "
                  "this app can help you find the right fit.",
                  style: GoogleFonts.zenKurenaido(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'signin_button',
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        _routeSignIn(),
                      ),
                      // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => GoogleUserForm())),
                      child: Text('Sign in'),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff072A6C),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 18.h,
                        ),
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Hero(
                    tag: 'signup_button',
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        _routeSignUp(),
                      ),
                      // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PhoneUserForm())),
                      child: Text('Sign up'),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff072A6C),
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 18.h,
                        ),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Via Social Media',
                    style: TextStyle(
                      color: kMainColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Hero(
                    tag: 'social_buttons',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SocialButton(
                          backgroundColor: Color(0xff072A6C),
                          icon: FontAwesomeIcons.facebookF,
                          onPressed: () {
                            _launchInBrowser('https://www.facebook.com');
                          },
                        ),
                        SocialButton(
                          backgroundColor: Colors.red,
                          icon: FontAwesomeIcons.google,
                          onPressed: () {
                            final gProvider = Provider.of<GoogleSignInProvider>(
                                context,
                                listen: false);
                            gProvider.googleLogIn();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: kBackGroundColor,
                child: Center(
                  child: CircularProgressIndicator(color: kMainColor),
                ),
              );
            } else if (snapshot.hasData) {
              return GoogleUserForm();
            } else if (snapshot.hasError) {
              return Container(
                  child: Center(child: Text("Something went wrong")));
            } else {
              return welcomeScreen();
            }
          }),
    );
  }

  PageRouteBuilder _routeSignIn() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Sign_inScreen();
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

  PageRouteBuilder _routeSignUp() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Sign_upScreen();
        //return HomeScreen();
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

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }
}
