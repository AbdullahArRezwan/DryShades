import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Authentication-Screen/VerifiedScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Utils.dart';
import 'package:dry_shades/UI/Main_Screen/Screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleUserForm extends StatefulWidget {
  const GoogleUserForm({Key? key}) : super(key: key);

  @override
  State<GoogleUserForm> createState() => _GoogleUserFormState();
}

class _GoogleUserFormState extends State<GoogleUserForm> {
  final formKey = GlobalKey<FormState>();
  String fullName = '';
  String phone = '';
  String email = '';
  String address = '';
  String newPassword = "";
  FocusNode labelColor = FocusNode();
  bool passObscure = true;
  bool confirmObscure = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;

  registration() async {
    try {
      CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("UserData");
      return collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).set({
        "FullName": user!.displayName,
        "Email": user!.email,
        "PhoneNumber": phoneController.text.trim(),
        "Password": passwordController.text.trim(),
        "Address": addressController.text.trim(),
        "ImageUrl": user!.photoURL,
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Container(
          padding:
              EdgeInsets.only(top: 40.w, left: 20.w, right: 20.w, bottom: 20.w),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Complete your profile",
                  style: GoogleFonts.zenKurenaido(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w900,
                    color: kMainColor,
                  ),
                ),
                SizedBox(height: 20.h),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildNameField(user!.displayName),
                      buildEmailField(user!.email),
                      buildNumberField(),
                      buildAddressField(),
                      SizedBox(height: 10.w),
                      Text(
                        "Create your own password",
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: kMainColor,
                        ),
                      ),
                      SizedBox(height: 15.w),
                      buildPasswordField(),
                      buildConfirmPasswordField(),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();

                      if (isValid) {
                        formKey.currentState!.save();
                        registration();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VerifiedScreen()));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile successfully created")));
                      }
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 2.2,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: kMainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNameField(String? displayName) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        focusNode: labelColor,
        controller: nameController = TextEditingController(text: displayName),
        onSaved: (value) {
          setState(() {
            fullName = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Full Name",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: Icon(
              CupertinoIcons.person,
            color: kMainColor,
          ),
        ),
        validator: (input) {
          if (input == null || input.isEmpty) {
            return "Please enter your Full Name";
          } else
            return null;
        },
      ),
    );
  }
  Widget buildEmailField(String? email) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: emailController = TextEditingController(text: email),
        onSaved: (value) {
          setState(() {
            email = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Email",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: Icon(
            CupertinoIcons.mail,
            color: kMainColor,
          ),
        ),
        validator: (value) {
          final pattern =
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
          final regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return "Please enter your Email";
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
      ),
    );
  }
  Widget buildNumberField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: phoneController,
        onSaved: (value) {
          setState(() {
            phone = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Phone Number",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1.w,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: Icon(
            CupertinoIcons.phone,
            color: kMainColor,
          ),
        ),
        validator: (value) {
          final pattern = r'(^[0-9]{11}$)';
          final regExp = RegExp(pattern);
          if (value!.isEmpty) {
            return 'Please enter your Phone Number';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid phone number';
          } else {
            return null;
          }
        },
      ),
    );
  }
  Widget buildAddressField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: addressController,
        onSaved: (value) {
          setState(() {
            address = value!;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          labelText: "Address",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: Icon(
            CupertinoIcons.house,
            color: kMainColor,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter your Address";
          } else
            return null;
        },
      ),
    );
  }
  Widget buildPasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: passwordController,
        autovalidateMode: AutovalidateMode.always,
        validator: (pass) {
          if (RegExp(
                  r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
              .hasMatch(pass!)) {
            return null;
          } else if(pass.isEmpty){
            return "Please enter a valid Password";
          } else {
            return "Minimum 8 character long with special character, uppercase\n"
                "& lowercase letter with number";
          }
        },
        obscureText: passObscure,
        decoration: InputDecoration(
          labelText: "Password",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: Icon(
            CupertinoIcons.lock,
            color: kMainColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passObscure = !passObscure;
              });
            },
            icon: passObscure
                ? Icon(Icons.visibility_off, color: kMainColor)
                : Icon(Icons.visibility, color: kMainColor),
          ),
        ),
      ),
    );
  }
  Widget buildConfirmPasswordField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.w,
      ),
      child: TextFormField(
        controller: confirmPasswordController,
        autovalidateMode: AutovalidateMode.always,
        validator: (pass) {
          if(pass!.isEmpty){
            return null;
          }
          if (passwordController.text != confirmPasswordController.text) {
            return "Entered Password does not match";
          }
        },
        obscureText: confirmObscure,
        decoration: InputDecoration(
          labelText: "Confirm Password",
          floatingLabelStyle: TextStyle(
            color: kMainColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kMainColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20.r),
          ),
          prefixIcon: Icon(
            CupertinoIcons.lock,
            color: kMainColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                confirmObscure =! confirmObscure;
              });
            },
            icon: confirmObscure
                ? Icon(Icons.visibility_off, color: kMainColor)
                : Icon(Icons.visibility, color: kMainColor),
          ),
        ),
      ),
    );
  }
}
