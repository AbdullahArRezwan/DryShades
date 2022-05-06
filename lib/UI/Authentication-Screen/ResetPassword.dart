import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  Future resetPassword() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      Fluttertoast.showToast(msg: "Password reset email sent");
    } on FirebaseAuthException catch (e){
      print(e);
      Fluttertoast.showToast(msg: '$e.message');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Colors.lightBlue,
        ),
        title: Text("Reset Password",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 36.sp,
            fontWeight: FontWeight.bold,
            color: Colors.lightBlue,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.w),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Enter your email and we will send",
                    style: GoogleFonts.zenKurenaido(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("you a password reset link",
                    style: GoogleFonts.zenKurenaido(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              TextFormField(
                controller: _emailController,
                validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? "Enter a valid email"
                    : null,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                  prefixIcon: Icon(Icons.mail_outline,
                    color: Colors.lightBlue,
                  ),
                  suffixIcon: IconButton(onPressed: null,
                    icon: Icon(Icons.check_circle,
                      color: Colors.lightBlue,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.lightBlue,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 57.h,
                  child: ElevatedButton(
                    onPressed: resetPassword,
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
                        padding: EdgeInsets.all(14.0),
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
                              'Reset Password',
                              style: TextStyle(fontSize: 22.sp),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }
}
