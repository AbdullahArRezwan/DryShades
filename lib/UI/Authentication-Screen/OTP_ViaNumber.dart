import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Authentication-Screen/OTP_Screen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OTP_ViaNumber extends StatefulWidget {
  const OTP_ViaNumber({Key? key}) : super(key: key);

  @override
  _OTP_ViaNumberState createState() => _OTP_ViaNumberState();
}

class _OTP_ViaNumberState extends State<OTP_ViaNumber> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController numberController = TextEditingController();
  late String verificationId;

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("UserData");
    return _collectionRef.doc(currentUser!.uid).set({
      "FullName": "Name",
      "Email": "Email",
      "PhoneNumber": numberController.text.trim(),
      "Password": "Password",
      "Address": "Address",
      "ImageUrl":
          "https://firebasestorage.googleapis.com/v0/b/e-shop-273fa.appspot.com/o/UserProfile%2Ficon.jpg?alt=media&token=94932f6e-c31b-465f-b4d2-0e5c8715be3f",
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
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
                      width: 190.w,
                      height: 190.h,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: Image.asset(
                          'assets/images/OTP 2.jpg',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      'Sign-up via Mobile Number',
                      style: GoogleFonts.zenKurenaido(
                        //supermercadoOne
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 37.sp,
                        fontWeight: FontWeight.w900,
                        color: kMainColor,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Please enter your phone number. we'll send you a verification code to verify your account",
                      style: GoogleFonts.zenKurenaido(
                        //supermercadoOne
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      padding: EdgeInsets.all(28.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: numberController,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10.r)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10.r)),
                              prefix: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '(+880)',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.check_circle,
                                color: Color(0xff072A6C),
                                size: 22.w,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OTP_Screen(
                                          phone: numberController.text,
                                          countryCode: "+88",
                                        )));
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff072A6C)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.w),
                                child: Text(
                                  'Send',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
