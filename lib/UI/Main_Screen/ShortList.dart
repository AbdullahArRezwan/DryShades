import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortList extends StatelessWidget {
  const ShortList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.w),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users-Favourite-House")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("House")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something is wrong"),
                );
              }
              return ListView.builder(
                  itemCount:
                  snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                    snapshot.data!.docs[index];
                    return Container(
                      height: 130.h,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.network(
                                _documentSnapshot["Image"],
                                width: 150.w,
                                height: 130.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _documentSnapshot["Name"],
                                    style: GoogleFonts.zenKurenaido(
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _documentSnapshot["Address"],
                                              style: GoogleFonts.zenKurenaido(
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.none,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 5.w),
                                            Text(
                                              _documentSnapshot["Price"],
                                              style: GoogleFonts.zenKurenaido(
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.none,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              _documentSnapshot["Code"],
                                              // style: Theme.of(context).textTheme.headline6,
                                              style: GoogleFonts.zenKurenaido(
                                                fontStyle: FontStyle.normal,
                                                decoration: TextDecoration.none,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("Users-Favourite-House")
                                              .doc(FirebaseAuth.instance.currentUser!.uid)
                                              .collection("House")
                                              .doc(_documentSnapshot.id)
                                              .delete();
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
