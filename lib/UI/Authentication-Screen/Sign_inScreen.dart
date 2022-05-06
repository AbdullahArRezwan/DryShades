import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/FirebaseLogic/GoogleSigninProvider.dart';
import 'package:dry_shades/UI/Authentication-Screen/GoogleUserForm.dart';
import 'package:dry_shades/UI/Authentication-Screen/ResetPassword.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Social_Buttons.dart';
import 'package:dry_shades/UI/Main_Screen/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'OTP_ViaNumber.dart';
import 'Sign_upScreen.dart';
//rezu 01

class Sign_inScreen extends StatefulWidget {
  const Sign_inScreen({Key? key}) : super(key: key);

  @override
  _Sign_inScreenState createState() => _Sign_inScreenState();
}

class _Sign_inScreenState extends State<Sign_inScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscure = true;
  final formKey = GlobalKey<FormState>();

  // void clearText() {
  //   _emailController.clear();
  //   _passwordController.clear();
  // }

  final user = FirebaseAuth.instance.currentUser;

  var email = "";
  var password = "";
  final storage = new FlutterSecureStorage();

  userLogin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      var authCredential = userCredential.user;
      await storage.write(key: "uid", value: userCredential.user?.uid);
      if (authCredential!.uid.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Screens()));
      } else {
        Fluttertoast.showToast(msg: "Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong password provided for that user.");
      }
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackGroundColor,
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(40.w),
            child: Column(
              children: [
                SizedBox(height: 15.h),
                Hero(
                  tag: 'text',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Welcome Back!',
                      style: GoogleFonts.zenKurenaido(
                        //supermercadoOne
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 38.sp,
                        fontWeight: FontWeight.w900,
                        color: kMainColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Hero(
                    tag: 'image',
                    child: Image.asset(
                      'assets/images/welcomeTwo.jpg',
                    ),
                  ),
                ),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Color(0xff072A6C),
                    ),
                    suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.check_circle,
                        color: Color(0xff072A6C),
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff072A6C),
                        )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff072A6C),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.lock,
                      color: Color(0xff072A6C),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: _obscure
                          ? Icon(Icons.visibility_off, color: Color(0xff072A6C))
                          : Icon(Icons.visibility, color: Color(0xff072A6C)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff072A6C),
                        )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff072A6C),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(children: [
                  Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      _resetPassword(),
                    ),
                    child: Text('Forgot Password',
                        style: TextStyle(
                          color: Color(0xff072A6C),
                        )),
                  ),
                  SizedBox(height: 16.h),
                ]),
                Hero(
                  tag: 'signin_button',
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          email = _emailController.text;
                          password = _passwordController.text;
                        });
                        userLogin();
                      }
                    },
                    child: Text('Sign in'),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xff072A6C),
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 18.h,
                      ),
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    _viaMobileNumber(),
                  ),
                  child: Text('Sign-up Via Number',
                      style: TextStyle(
                        color: Color(0xff072A6C),
                      )),
                ),
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
                SizedBox(height: 16.h),
                GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      _backSignUp(),
                    ),
                    child: Text('Don\'t have an account? Sign Up')),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

PageRouteBuilder _resetPassword() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ResetPassword();
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

PageRouteBuilder _backSignUp() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Sign_upScreen();
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

PageRouteBuilder _viaMobileNumber() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return OTP_ViaNumber();
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
