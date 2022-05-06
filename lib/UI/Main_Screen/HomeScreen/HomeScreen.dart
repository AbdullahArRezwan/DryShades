import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Main_Screen/HomeScreen/BuyCommercial/BuyCommercial.dart';
import 'package:dry_shades/UI/Main_Screen/HomeScreen/BuyHome/BuyHome.dart';
import 'package:dry_shades/UI/Main_Screen/HomeScreen/RentCommercial/RentCommercial.dart';
import 'package:dry_shades/UI/Main_Screen/Screens.dart';
import 'package:dry_shades/UI/Others_Screen/Requiement.dart';
import 'package:dry_shades/UI/PostScreen/PostScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  int current = 0;

  // List<CardItem> items = [
  //   CardItem(
  //     id: 'c1',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //     title: 'Buying a home',
  //   ),
  //   CardItem(
  //     id: 'c2',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //     title: 'Renting a home',
  //   ),
  //   CardItem(
  //     id: 'c3',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //     title: 'Sell Your Propery/Land',
  //   ),
  //   CardItem(
  //     id: 'c4',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1600607687644-c7171b42498f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //     title: 'Paying Guest',
  //   ),
  //   CardItem(
  //     id: 'c5',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //     title: 'Co-living spaces for Male',
  //   ),
  //   CardItem(
  //     id: 'c6',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //     title: 'Co-living spaces for Female',
  //   ),
  //   CardItem(
  //     id: 'c7',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1549517045-bc93de075e53?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80',
  //     title: 'Buy Commercial property',
  //   ),
  //   CardItem(
  //     id: 'c8',
  //     urlImage:
  //         'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
  //     title: 'Rent Commercial property',
  //   ),
  // ];

  // void listSelectCategory(BuildContext ctx, int index) {
  //   Navigator.of(ctx).pushNamed(PostScreen.postScreenRouteName,
  //       arguments: {'id': items[index].id, 'title': items[index].title});
  // }
  //
  // void selectCategory(BuildContext ctx, CardItem item, int index) {
  //   Navigator.of(ctx).pushNamed(PostScreen.postScreenRouteName,
  //       arguments: {'id': items[index].id, 'title': items[index].title});
  // }

  // List<String> CarouselImages = [
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Flycs-architecture-kUdbEEMcRwE-unsplash.jpg?alt=media&token=2549ba35-d5ab-4162-87bb-b9f80f47f41d",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Fdigital-marketing-agency-ntwrk-g39p1kDjvSY-unsplash.jpg?alt=media&token=0bd6a8c7-6319-40e4-920e-1dac3e370d2a",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Fvita-vilcina-KtOid0FLjqU-unsplash.jpg?alt=media&token=86e73bcf-0625-41b2-abb7-8a49436e0795",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Fjane-last-BSwQWHfdU8g-unsplash.jpg?alt=media&token=adc35188-9a12-4ed7-9782-2386d7e8e257",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Flissete-laverde-7OFTxbGWqwk-unsplash.jpg?alt=media&token=bc6c1cf9-dc3f-48fc-a1b6-00c1a8f12000",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Fpascal-meier-b7ilvCZnRX0-unsplash.jpg?alt=media&token=a05b2bfa-9798-41f9-bef8-eb3c10b2597d",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Fr-architecture-2gDwlIim3Uw-unsplash.jpg?alt=media&token=40c80287-ccbc-4968-9d3f-624561c47f0a",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Fbuy_commercial.jpg?alt=media&token=aed7fd1d-1bd2-48f8-a897-3317d231bd0b",
  //   "https://firebasestorage.googleapis.com/v0/b/dryshades-ccf67.appspot.com/o/CarouselSlider%2Frodeo-project-management-software-PYqzYhTNjho-unsplash.jpg?alt=media&token=71cf396e-494f-43dd-843d-01fbd32783e3",
  // ];

  @override
  void initState() {
    carouselSlider();
    super.initState();
  }

  greetings() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return Text(
        "Good Morning",
        style: GoogleFonts.inter(
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xfff7f6fb),
        ),
      );
    } else if (hour < 17) {
      return Text(
        "Good Afternoon",
        style: GoogleFonts.inter(
          fontStyle: FontStyle.normal,
          decoration: TextDecoration.none,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xfff7f6fb),
        ),
      );
    }
    return Text(
      "Good Evening",
      style: GoogleFonts.inter(
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xfff7f6fb),
      ),
    );
  }

  List carouselSliderList = [];
  carouselSlider() async {
    QuerySnapshot qn =
    await FirebaseFirestore.instance.collection("Carousel-Slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        carouselSliderList.add({
          "Carousel-Image": qn.docs[i]["Images"],
        });
      }
    });
    return qn.docs;
  }

  buildHomeScreen(data) {
    return Container(
      //margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ListView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        children: [
          Center(
            child: Container(
              height: 300.h,
              child: CarouselSlider(
                  items: carouselSliderList[index]["Carousel-Image"].map<Widget>((item) => Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      child: Image.network(
                        item,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                  )).toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      aspectRatio: 1.5,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      })),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselSliderList[0]["Carousel-Image"].map<Widget>((url) {
              int index = carouselSliderList[0]["Carousel-Image"].indexOf(url);
              return Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 3,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: current == index ? Colors.blue : Colors.grey),
              );
            }).toList(),
          ),
          SizedBox(height: 10.h),
          Material(
            color: Colors.white,
            elevation: 6,
            shadowColor: kMainColor,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  color: Color(0xff072A6C),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff17076C),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 4.r,
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    greetings(),
                    SizedBox(height: 8.h),
                    Text(
                      data["FullName"],
                      style: GoogleFonts.inter(
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900,
                        color: Color(0xfff7f6fb),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // SizedBox(height: 18.h),
          // GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     height: 50.h,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20.r),
          //         color: Color(0xfff7f6fb),
          //         border: Border.all(color: Color(0xff072A6C))),
          //     //color: Colors.white,
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(
          //         //vertical: 2,
          //         horizontal: 20,
          //       ),
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: Text(
          //               "Search by Location or Project",
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 16.sp,
          //               ),
          //             ),
          //           ),
          //           SvgPicture.asset(
          //             'assets/svg/fi-rr-search.svg',
          //             //'assets/svg/insight_tracking_white.svg',
          //             color: Colors.black,
          //           ),
          //           SizedBox(width: 10.w),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 18.h),
          // Material(
          //   elevation: 10,
          //   borderRadius: BorderRadius.all(Radius.circular(20.r)),
          //   child: Container(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 20,
          //       vertical: 13,
          //     ),
          //     height: 130.h,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20.r),
          //         color: Color(0xfff7f6fb),
          //         border: Border.all(color: Color(0xff072A6C))),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "What kind of a Property are you looking for?",
          //           style: TextStyle(
          //             fontSize: 20.sp,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //         SizedBox(height: 12.h),
          //         Text(
          //           'Share with us to get Exclusive Proposals',
          //           style: TextStyle(
          //             color: Colors.grey.shade700,
          //             fontSize: 14.sp,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //         SizedBox(height: 4.h),
          //         OutlinedButton(
          //           onPressed: () {
          //             Navigator.of(context).push(_requirement());
          //           },
          //           // style: ButtonStyle(
          //           //   shape: MaterialStateProperty.all(
          //           //       RoundedRectangleBorder(
          //           //         borderRadius: BorderRadius.circular(20.0),
          //           //       ),
          //           //   ),
          //           // ),
          //           style: OutlinedButton.styleFrom(
          //             shape: StadiumBorder(),
          //             side: BorderSide(color: Colors.black, width: 1),
          //           ),
          //           child: Text(
          //             'Share Requirement',
          //             style: TextStyle(
          //               color: Color(0xff072A6C),
          //               fontWeight: FontWeight.w600,
          //               fontSize: 16.sp,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // SizedBox(height: 14.h),
          Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 65.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Color(0xfff7f6fb),
                // border: Border.all(color: Color(0xff072A6C))
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get Started With",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "exploring property options in top areas",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 220.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                vertical: 5.w,
              ),
              child: Row(
                children: [
                  buildCard(
                      imagePath: "assets/categoryFront/Buy_Home.jpg",
                      categoryTitle: "Buying Home",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BuyHome()))
                  ),
                  SizedBox(width: 10.w),
                  buildCard(
                      imagePath: "assets/categoryFront/Rent_Home.jpg",
                      categoryTitle: "Renting Home",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BuyHome()))
                  ),
                  SizedBox(width: 10.w),
                  buildCard(
                      imagePath: "assets/categoryFront/Sell_Property.jpg",
                      categoryTitle: "Sell Property/Building",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BuyHome()))
                  ),
                  SizedBox(width: 10.w),
                  buildCard(
                      imagePath: "assets/categoryFront/Paying_Guest.jpg",
                      categoryTitle: "Paying Guest",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BuyHome()))
                  ),
                  SizedBox(width: 10.w),
                  buildCard(
                      imagePath: "assets/categoryFront/Co-living_Male.jpg",
                      categoryTitle: "Co-living Space for Male",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BuyHome()))
                  ),
                  SizedBox(width: 10.w),
                  buildCard(
                      imagePath: "assets/categoryFront/Co-living_Female.jpg",
                      categoryTitle: "Co-living Space for Female",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BuyHome()))
                  ),
                  SizedBox(width: 10.w),
                  buildCard(
                      imagePath: "assets/categoryFront/Buy_Commercial.jpg",
                      categoryTitle: "Buy Commercial Property",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BuyCommercial()))
                  ),
                  SizedBox(width: 10.w),
                  buildCard(
                      imagePath: "assets/categoryFront/Rent_Commercial.jpg",
                      categoryTitle: "Rent Commercial Property",
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RentCommercial()))
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Buying Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Apartments, land, builder floors, villas and more",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Buy_Home.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BuyHome())),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Explore all home buying options",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Over 100 properties and 30 projects",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Renting Home",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Apartments, builder floors, villas and more",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Rent_Home.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BuyHome())),
                            // onTap: () {
                            //   Navigator.of(context).push(_postScreen());
                            // },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Explore all home renting options",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Over 130 properties and 40 projects",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sell your Property/Building",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Close the deal faster with DryShades",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Sell_Property.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BuyHome())),
                            // onTap: () {
                            //   Navigator.of(context).push(_postScreen());
                            // },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Post your property for Free",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Option to get assistance & free verification",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Paying Guest",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Organised, owner and broker listed PGs",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Paying_Guest.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BuyHome())),
                            // onTap: () {
                            //   Navigator.of(context).push(_postScreen());
                            // },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Explore all PG options",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Over 40 properties | 35+ owner listed",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Co-living spaces for Male",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Organised, owner and broker listed Male Co-living options",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Co-living_Male.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BuyHome())),
                            // onTap: () {
                            //   Navigator.of(context).push(_postScreen());
                            // },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Explore all Male Co-living options",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Over 30 properties | 20+ owner listed",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Co-living spaces for Female",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Organised, owner and broker listed Female Co-living options",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Co-living_Female.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BuyHome())),
                            // onTap: () {
                            //   Navigator.of(context).push(_postScreen());
                            // },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Explore all Female Co-living options",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Over 30 properties | 20+ owner listed",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Buying commercial property",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Shops, offices, land, factories, warehouses and more",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Buy_Commercial.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => BuyCommercial())),
                            // onTap: () {
                            //   Navigator.of(context).push(_postScreen());
                            // },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Explore all Commercial buying options",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Over 100 properties & 30 projects",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Container(
            height: 350.h,
            // color: Colors.blue,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                // horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Renting commercial property",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Shops, offices, land, factories, warehouses and more",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Material(
                        child: Ink.image(
                          image: AssetImage(
                            "assets/categoryFront/Rent_Commercial.jpg",
                          ),
                          fit: BoxFit.cover,
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => RentCommercial())),
                            // onTap: () {
                            //   Navigator.of(context).push(_postScreen());
                            // },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        "Explore all Commercial Renting options",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(CupertinoIcons.arrow_right_square,
                          color: Colors.black, size: 18),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Over 200 properties & 70 projects",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      // color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("UserData")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Container(
              color: kBackGroundColor,
              child:
                  Center(child: CircularProgressIndicator(color: kMainColor)),
            );
          }
          return buildHomeScreen(data);
        },
      ),
    );
  }
  Widget buildCard(
      {required String imagePath,
      required String categoryTitle,
      VoidCallback? onPressed}) {
    return Container(
        width: 170.w,
        child: Column(
          children: [
            SizedBox(height: 8.h),
            Expanded(
              child: AspectRatio(
                aspectRatio: 2.5, // 4 by 3
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Material(
                    child: Ink.image(
                      image: AssetImage(
                        imagePath,
                      ),
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: onPressed,
                        // onTap: () {
                        //   Navigator.of(context).push(_postScreen());
                        // },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              categoryTitle,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ));
  }
}

// PageRouteBuilder _postScreen() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) {
//       return PostScreen(categoryTitle:  , categoryId: '',);
//     },
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(1.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ).animate(animation),
//         child: child,
//       );
//     },
//     transitionDuration: const Duration(seconds: 1),
//     reverseTransitionDuration: const Duration(seconds: 1),
//   );
// }
PageRouteBuilder _requirement() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return Requirement();
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
