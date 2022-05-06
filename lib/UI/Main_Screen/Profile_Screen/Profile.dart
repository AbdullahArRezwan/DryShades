import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/FirebaseLogic/GoogleSigninProvider.dart';
import 'package:dry_shades/UI/Authentication-Screen/Sign_inScreen.dart';
import 'package:dry_shades/UI/Authentication-Screen/WelcomeScreen.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'ChangePassword.dart';
import 'EditProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = FirebaseAuth.instance.currentUser!;
  final storage = new FlutterSecureStorage();

  setDataToProfile(data) {
    return Column(
      children: [
        ProfilePic(data: data),
        SizedBox(height: 20.h),
        Text(
          data["FullName"],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: kMainColor,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          data["Email"],
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: kMainColor,
            //color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          data["PhoneNumber"],
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: kMainColor,
            //color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.w,
            ),
            child: Text(
              "Upgrade to Premium",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            // primary: Colors.greenAccent,
            primary: kMainColor,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        ProfileMenu(
          text: "Edit Profile",
          icon: Icons.account_circle,
          press: () => {Navigator.of(context).push(_editProfile())},
        ),
        ProfileMenu(
          text: "Change Password",
          icon: Icons.lock,
          press: () => {Navigator.of(context).push(_changePassword())},
        ),
        ProfileMenu(
          text: "Create Advertisement",
          icon: Icons.post_add_outlined,
          press: () {},
        ),
        ProfileMenu(
          text: "Setting",
          icon: Icons.settings,
          press: () {},
        ),
        ProfileMenu(
          text: "Help & Support",
          icon: Icons.help_outlined,
          press: () {},
        ),
        ProfileMenu(
          text: "Send Feedback",
          icon: Icons.feedback,
          press: () {},
        ),
        ProfileMenu(
          text: "Log Out",
          icon: Icons.logout,
          press: () async {
            await storage.delete(key: "uid");
            await FirebaseAuth.instance.signOut().then((value) =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (route) => false));
            final gProvider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            gProvider.logOut();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.w),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("UserData")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Container(
                color: kBackGroundColor,
                child: Center(
                    child: CircularProgressIndicator(color: kMainColor)),
              );
            }
            return setDataToProfile(data);
          },
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  var data;
  ProfilePic({
    Key? key, required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: 140.w,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 130.w,
            height: 130.h,
            decoration: BoxDecoration(
              border: Border.all(width: 4.w, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 2.r,
                    blurRadius: 10.r,
                    color: Colors.black.withOpacity(0.1))
              ],
              shape: BoxShape.circle,
              // image: DecorationImage(
              //     fit: BoxFit.cover,
              //     image: AssetImage("assets/images/IMG20220215145450.jpg"),
              // ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.network(
                data["ImageUrl"],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            right: 10, //-16
            bottom: -5,
            child: SizedBox(
              height: 40.h, //46
              width: 40.w, //46
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    side: BorderSide(color: Colors.white, width: 3.w),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xffefe6dc),
                  //backgroundColor: Color(0xff072A6C),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/svg/Camera Icon.svg",
                    color: kMainColor.withOpacity(1.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    this.press,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kMainColor,
          // padding: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.w,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          backgroundColor: kMainWhiteColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: kMainColor,
              size: 25,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

PageRouteBuilder _editProfile() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return EditProfile();
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

PageRouteBuilder _changePassword() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return ChangePassword();
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
