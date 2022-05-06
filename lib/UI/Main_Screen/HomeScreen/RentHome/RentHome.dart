import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RentHome extends StatelessWidget {
  const RentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: kMainColor,
        ),
        title: Text("Rent Home",
          style: GoogleFonts.courgette(
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: kMainColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            InkWell(
              onTap: (){},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                elevation: 4,
                margin: EdgeInsets.all(10.w),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: Ink.image(
                            image: NetworkImage("https://images.unsplash.com/photo-1599809275671-b5942cabc7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: (){},
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: Container(
                            width: 300.w,
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                              vertical: 5.w,
                              horizontal: 20.w,
                            ),
                            child: Text(
                              "Rumi Holdings",
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_rounded,
                                color: kMainColor,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "Pirerbazar",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Icon(Icons.money_off_csred_rounded),
                              Icon(Icons.attach_money_rounded,
                                color: kMainColor,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "BDT 1,00,000",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){},
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                elevation: 4,
                margin: EdgeInsets.all(10.w),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: Ink.image(
                            image: NetworkImage("https://images.unsplash.com/photo-1599809275671-b5942cabc7a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: (){},
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: Container(
                            width: 300.w,
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                              vertical: 5.w,
                              horizontal: 20.w,
                            ),
                            child: Text(
                              "Shanti Bari",
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_rounded,
                                color: kMainColor,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "Pirerbazar",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Icon(Icons.money_off_csred_rounded),
                              Icon(Icons.attach_money_rounded,
                                color: kMainColor,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "BDT 1,00,000",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kMainColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
