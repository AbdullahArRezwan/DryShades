import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Authentication-Screen/Sign_inScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();
  bool _obscure = true;
  bool isLoading = false;
  String newPassword = "";
  final currentUser = FirebaseAuth.instance.currentUser;


  updateData() {
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("UserData");
    return collectionRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "Password": _newPasswordController.text.trim(),
    });
  }


  Future changePassword() async {
    try{
      await currentUser!.updatePassword(newPassword);
      updateData();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Sign_inScreen()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your password has been changed. Signin again")));
    } catch (e){
      print(e);
    }
  }
  checkPassword(data){
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30.w,
          vertical: 60.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Enter your current password",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: kMainColor,
              ),
            ),
            SizedBox(height: 20.h),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: _currentPasswordController,
              obscureText: _obscure,
              validator: (value) {
                if(_currentPasswordController.text.isEmpty){
                  return "Please enter your current password";
                }
                else if (_currentPasswordController.text != data["Password"]) {
                  return "Current Password does not match";
                }
              },
              decoration: InputDecoration(
                hintText: "Current Password",
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
                      color: Colors.red,
                    )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff072A6C),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              "Minimum 8 character long with special character, uppercase & lowercase "
                  "letter with number",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: kMainColor,
              ),
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: _newPasswordController,
              autovalidateMode: AutovalidateMode.always,
              validator: (pass) {
                if (RegExp(
                    r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                    .hasMatch(pass!)) {
                  return null;
                } else {
                  return "Enter a valid Password";
                }
              },
              obscureText: _obscure,
              decoration: InputDecoration(
                hintText: "New Password",
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
                      color: Colors.red,
                    )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff072A6C),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: _confirmNewPasswordController,
              obscureText: _obscure,
              validator: (value) {
                if (_newPasswordController.text != _confirmNewPasswordController.text) {
                  return "Entered New Password does not match";
                }
              },
              decoration: InputDecoration(
                hintText: "Confirm New Password",
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
                      color: Colors.red,
                    )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff072A6C),
                  ),
                ),
              ),
            ),
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 16.sp,
                        letterSpacing: 2.2,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      if (isValid) {
                        setState((){
                          newPassword = _newPasswordController.text.trim();
                        });
                        changePassword();
                      }                    },
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Color(0xff072A6C),
        ),
        title: Text(
          "Change Password",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.w900,
            color: Color(0xff072A6C),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: kBackGroundColor,
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(color: kMainColor)
                : Column(
              children: [
                SizedBox(height: 40.w),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("UserData")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    var data = snapshot.data;
                    if (data == null) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: Colors.lightBlue));
                    }
                    return checkPassword(data);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
