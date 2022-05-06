import 'package:dry_shades/UI/Authentication-Screen/PhoneUserForm.dart';
import 'package:dry_shades/UI/Authentication-Screen/VerifiedScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTP_Screen extends StatefulWidget {
  final String phone;
  final String countryCode;
  const OTP_Screen({Key? key, required this.phone, required this.countryCode})
      : super(key: key);

  @override
  _OTP_ScreenState createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  TextEditingController otpController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  @override
  void initState() {
    super.initState();
    verifyMobileNumber();
  }

  verifyMobileNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.countryCode+widget.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) {
          if (value.user != null) {
            Fluttertoast.showToast(
              msg: "Account successfully created",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.lightBlue,
              textColor: Colors.white,
              fontSize: 16.sp,
            );
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screens()));
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Utils.showSnackBar(e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      textStyle: TextStyle(
          fontSize: 20.sp,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 12.w,
          ),
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
                    // SizedBox(
                    //   height: 30.h,
                    // ),
                    Container(
                        alignment: Alignment.center,
                        width: 190.w,
                        height: 190.h,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: Image.asset(
                            'assets/images/mobile animation 2.jpg',
                          ),
                        )),
                    SizedBox(
                      height: 24.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Verify your mobile number",
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.phone}",
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: kMainColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "please enter the 6-digit verification code that was",
                        style: GoogleFonts.zenKurenaido(
                          //supermercadoOne
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "sent to your mobile number",
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 130.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Pinput(
                              length: 6,
                              focusNode: _pinOTPCodeFocus,
                              controller: otpController,
                              androidSmsAutofillMethod:
                                  AndroidSmsAutofillMethod.smsRetrieverApi,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              validator: (pin) {
                                return pin == otpController.text
                                    ? 'Pin is correct'
                                    : 'Pin is incorrect';
                              },
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              onCompleted: (pin) async {
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithCredential(
                                          PhoneAuthProvider.credential(
                                              verificationId: verificationCode!,
                                              smsCode: pin))
                                      .then((value) {
                                    if (value.user != null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => PhoneUserForm(
                                                  phone: widget.phone)));
                                    }
                                  });
                                } catch (e) {
                                  FocusScope.of(context).unfocus();
                                  Utils.showSnackBar("OTP is incorrect");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15.w),
                    Text(
                      "Didn't you receive any code?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    GestureDetector(
                      onTap: verifyMobileNumber,
                      child: Text(
                        "Resend again",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: kMainColor,
                        ),
                        textAlign: TextAlign.center,
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
