import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyHomeDetails extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  const BuyHomeDetails({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  State<BuyHomeDetails> createState() => _BuyHomeDetailsState();
}

class _BuyHomeDetailsState extends State<BuyHomeDetails> {
  int current = 0;
  String phoneNumber = "01681301032";
  var currentUser = FirebaseAuth.instance.currentUser;

  Future addToFavourite() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("Users-Favourite-House");
    return _collectionRef.doc(currentUser!.uid).collection("House").doc().set({
      "Name": widget.documentSnapshot["Name"],
      "Price": widget.documentSnapshot["Price"],
      "Address": widget.documentSnapshot["Address"],
      "Image": widget.documentSnapshot["Images"][0],
      "Code": widget.documentSnapshot["Code"],
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added to shortlist successfully"))));
  }

  _launchPhoneURL(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kBackGroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: kBackGroundColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 30.w,
                ),
                child: Stack(
                  children: [
                    Container(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Buying-Home")
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            return CarouselSlider(
                                items: widget.documentSnapshot["Images"]
                                    .map<Widget>((item) => Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.r),
                                            ),
                                            child: Image.network(
                                              item,
                                              fit: BoxFit.cover,
                                              width: 1000,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                options: CarouselOptions(
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.8,
                                    aspectRatio: 1,
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        current = index;
                                      });
                                    }));
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 25.w,
                        left: 15.w,
                        // right: 25.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey,
                                  size: 20.w,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.documentSnapshot["Images"].map<Widget>((url) {
                  int index = widget.documentSnapshot["Images"].indexOf(url);
                  return Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 3,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: current == index ? kMainColor : Colors.grey),
                  );
                }).toList(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    widget.documentSnapshot["Name"],
                    style: GoogleFonts.zenKurenaido(
                      fontStyle: FontStyle.normal,
                      decoration: TextDecoration.none,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: kMainColor,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.documentSnapshot["Address"],
                          style: GoogleFonts.zenKurenaido(
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.money_outlined,
                          color: kMainColor,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          widget.documentSnapshot["Price"],
                          style: GoogleFonts.zenKurenaido(
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Users-Favourite-House")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("House")
                        .where("Name",
                            isEqualTo: widget.documentSnapshot['Name'])
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text("");
                      }
                      return GestureDetector(
                        onTap: () => snapshot.data.docs.length == 0
                            ? addToFavourite()
                            : null,
                        child: snapshot.data.docs.length == 0
                            ? Row(
                                children: [
                                  Text(
                                    "Add to shortlist",
                                    style: GoogleFonts.zenKurenaido(
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Icon(
                                    Icons.favorite_outline,
                                    size: 20.w,
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    "Already added into shortlist",
                                    style: GoogleFonts.zenKurenaido(
                                      fontStyle: FontStyle.normal,
                                      decoration: TextDecoration.none,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Icon(
                                    Icons.favorite_outlined,
                                    size: 23.w,
                                    color: kMainColor,
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Property Details",
                      style: GoogleFonts.zenKurenaido(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Layout",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.documentSnapshot["Layout"],
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Carpet Area",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.documentSnapshot["Carpet-Area"],
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Furnishing",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.documentSnapshot["Furnishing"],
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Flooring",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.documentSnapshot["Flooring"],
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Power backup",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.documentSnapshot["Power-Backup"],
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    ClipRRect(
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 100.w,
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Property ID",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.documentSnapshot["Code"],
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  "Description",
                  style: GoogleFonts.zenKurenaido(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 170.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        "This fully furnished 3 BHK is available for rent in Sylhet with space for parking of car and bike. Take a look before it's gone.",
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      ExpandableText(
                          "If you need amenities such as battery back up, intercom facility, security, lift & Wi-Fi you will be happy to note that "
                              "this home has this & more. When you need gym, all you have to do is step out of the door as the apartment complex has what "
                              "you are looking for. With premium amenities such as air conditioner & fire safety this home provides you with many added benefits. "
                              "If you are in need of any emergency services or medical assistance, you will be happy to note that Ragib Rabeya Medical Hospital, "
                              "Mount Adora Hospital and Ibne Sina Hospital is near you. Access to bus station & medical stores is very easy & convenient from this house.",
                        textDirection: TextDirection.ltr,
                        style: GoogleFonts.zenKurenaido(
                          fontStyle: FontStyle.normal,
                          decoration: TextDecoration.none,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                          expandText: "See more",
                        collapseText: "See less",
                        maxLines: 6,
                        linkColor: kMainColor,

                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  "Other key facilities",
                  style: GoogleFonts.zenKurenaido(
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.none,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                height: 120.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    vertical: 5.w,
                  ),
                  child: Row(
                    children: [
                      FacilityCard(
                        icon: Icons.electric_bolt,
                        title: "Power Back-up",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.elevator_outlined,
                        title: "Elevator",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.fire_extinguisher_outlined,
                        title: "Fire alarm & Extinguisher",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.fire_truck,
                        title: "Waste Disposal",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.security_outlined,
                        title: "Security Personnel",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.water_drop_rounded,
                        title: "Water Storage",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.garage_rounded,
                        title: "Parking",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.ac_unit,
                        title: "Centrally Air conditioned",
                      ),
                      SizedBox(width: 15.w),
                      FacilityCard(
                        icon: Icons.photo_camera_front,
                        title: "CCTV Surveillance",
                      ),
                      SizedBox(width: 15.w),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(25.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () async {
                            _launchPhoneURL(phoneNumber);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            elevation: 2,
                            primary: kMainColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Call now",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Icon(Icons.call),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Container(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            elevation: 2,
                            primary: kMainColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Confirm House",
                                style: GoogleFonts.zenKurenaido(
                                  fontStyle: FontStyle.normal,
                                  decoration: TextDecoration.none,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Icon(Icons.check_circle),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget FacilityCard({required icon, required title}) {
    return Container(
      height: 110.h,
      width: 80.h,
      child: Column(
        children: [
          Icon(
            icon,
            size: 70.w,
            color: kMainColor,
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.zenKurenaido(
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
