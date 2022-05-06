import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/FirebaseLogic/GoogleSigninProvider.dart';
import 'package:dry_shades/UI/Authentication-Screen/EmailVerification.dart';
import 'package:dry_shades/UI/Authentication-Screen/GoogleUserForm.dart';
import 'package:dry_shades/UI/Authentication-Screen/OTP_ViaNumber.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Social_Buttons.dart';
import 'package:dry_shades/UI/Main_Screen/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
//rezu 01

class Sign_upScreen extends StatefulWidget {
  const Sign_upScreen({Key? key}) : super(key: key);

  @override
  _Sign_upScreenState createState() => _Sign_upScreenState();
}

class _Sign_upScreenState extends State<Sign_upScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var name = "";
  var email = "";
  var password = "";
  var confirmPassword = "";
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => EmailVerification(email: email)));
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(userCredential.user!.uid)
          .set({
        "FullName": "Name",
        "Email": _emailController.text.trim(),
        "PhoneNumber": "Phone",
        "Password": _passwordController.text.trim(),
        "Address": "Address",
        "ImageUrl":
            "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/UserProfile%2Ficon.jpg?alt=media&token=94932f6e-c31b-465f-b4d2-0e5c8715be3f",
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
      // Utils.showSnackBar(e.message);
    }
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
                SizedBox(height: 16.h),
                Hero(
                  tag: 'text',
                  child: Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Welcome to our Community!',
                      style: GoogleFonts.zenKurenaido(
                        //supermercadoOne
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w900,
                        color: kMainColor,
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'image',
                  child: Image.asset(
                    'assets/images/welcomeThree.jpg',
                    height: MediaQuery.of(context).size.height * 0.375,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _emailController,
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (email) {
                    if (RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email!)) {
                      return null;
                    } else {
                      return "Enter a valid email";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                    border: UnderlineInputBorder(),
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
                TextFormField(
                  controller: _passwordController,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (pass) {
                    if (RegExp(
                        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                        .hasMatch(pass!)) {
                      return null;
                    } else {
                      return "Minimum 8 character long with special character, uppercase & lowercase\n"
                          "letter with number";
                    }
                  },
                  obscureText: _obscurePass,
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
                          _obscurePass = !_obscurePass;
                        });
                      },
                      icon: _obscurePass
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
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPass,
                  validator: (value) {
                    if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      return "Password does not match";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
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
                          _obscureConfirmPass = !_obscureConfirmPass;
                        });
                      },
                      icon: _obscureConfirmPass
                          ? Icon(Icons.visibility_off, color: Color(0xff072A6C))
                          : Icon(Icons.visibility, color: Color(0xff072A6C)),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        )),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff072A6C),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Hero(
                    tag: 'signup_button',
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            email = _emailController.text;
                            password = _passwordController.text;
                            confirmPassword = _confirmPasswordController.text;
                          });
                          registration();
                        }
                      },
                      child: Text('Sign up'),
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
                ]),
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    _viaMobileNumber(),
                  ),
                  child: Text('Sign-up Via Number',
                      style: TextStyle(
                        color: Color(0xff072A6C),
                      )),
                ),
                SizedBox(height: 12.h),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
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
