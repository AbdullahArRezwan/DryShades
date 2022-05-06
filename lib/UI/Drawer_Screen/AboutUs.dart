import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

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
        title: Text("About Us",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.w900,
            color: Color(0xff072A6C),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 35,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome to DryShades!",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              fontSize: 17.sp,
              // color: Colors.black54,
              color: kMainColor,
            )),
            SizedBox(height: 12.h,),
            Text("DryShades is a disruptive real-estate platform that makes it possible to buy\/sell\/rent a house "
                "without paying any brokerage",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.italic,
              fontSize: 15.sp,
              // color: Colors.black54,
              color: kMainColor,
            )),
            SizedBox(height: 12.h,),
            Text("DryShades was started because all of us believed that paying hefty brokerage can not be the only option "
                "to find a new home. As tenants, we have been paying these brokerages year on year without seeing any "
                "advantage of the broker. The only reason he existed was that there was a huge information asymmetry in the"
                " market. DryShades is a platform that removes this information asymmetry and provides a marketplace for free "
                "exchange of this information that used to cost 1-2 months of rent as brokerage.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 15.sp,
                  // color: Colors.black54,
                  color: kMainColor,
                )),
            SizedBox(height: 12.h,),
            Text("We have done 2 things to help you find that perfect home:",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 15.sp,
                  // color: Colors.black54,
                  color: kMainColor,
                )),
            SizedBox(height: 12.h,),
            Padding(
                padding: EdgeInsets.only(
                  left: 12,
                ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: kMainColor.withOpacity(0.9),
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Text("Firstly, we have painstakingly verified each listing and made sure that these are direct owners or "
                            "shared accommodation parties and there are no middlemen or brokers. We use lot of heuristics and "
                            "techniques to ensure that you get a totally broker free list.",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 15.sp,
                          // color: Colors.black54,
                          color: kMainColor,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: kMainColor.withOpacity(0.9),
                      ),
                      SizedBox(width: 8.w,),
                      Expanded(
                        child: Text("Secondly, we have also tried to ensure that maximum information is available to you in as easy to use format. "
                            "This ensures that you get a very good idea of the property even before you visit it. Thus, you can shortlist flats "
                            "sitting at the comfort of your home without actually traveling all the good and bad properties. This saves your time "
                            "and effort and with a quick shortlist of 4-5 properties you can actually get a house in few hours!",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 15.sp,
                              // color: Colors.black54,
                              color: kMainColor,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Text("If you are a landlord interested in posting your apartments to DryShades, please email us at hello@dryshades.bd and "
                "we will get in touch to help you list the property.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 15.sp,
                  // color: Colors.black54,
                  color: kMainColor,
                )),
            SizedBox(height: 12.h,),
            Text("And tenants, happy hunting and get in touch with us to let us know how else we can help!",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: 15.sp,
                  // color: Colors.black54,
                  color: kMainColor,
                )),
          ],
        ),
      ),
    );
  }
}
