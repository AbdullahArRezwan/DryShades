import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PackersMovers extends StatefulWidget {
  const PackersMovers({Key? key}) : super(key: key);

  @override
  State<PackersMovers> createState() => _PackersMoversState();
}

class _PackersMoversState extends State<PackersMovers> with TickerProviderStateMixin {
  final cities = ["Sylhet", "Dhaka", "Chittagong", "Rajshahi", "Khulna", "Barisal", "Mymensingh", "Rangpur"];
  String? value;
  @override
  Widget build(BuildContext context) {
    TabController _tabBarController = TabController(length: 2 , vsync: this);
    DropdownMenuItem<String> buildMenuItem(String item) =>
        DropdownMenuItem(value: item, child: Text(item, style: TextStyle(color: Colors.grey.shade700)));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Color(0xff072A6C),
        ),
        title: Text("Packers & Movers",
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.w900,
            color: Color(0xff072A6C),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 30.w,
          ),
          child: ListView(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    //labelPadding: EdgeInsets.only(left: 0, right: 0),
                    labelColor: kMainColor,
                    unselectedLabelColor: Colors.grey.shade500,
                    controller: _tabBarController,
                    // indicator: ,
                    indicatorColor: kMainColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    // indicatorPadding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.w),
                    labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                    tabs: [
                      Tab(text: "Within the City",),
                      Tab(text: "Between Cities"),
                      ]
                  ),
                ),
              ),
              Container(
                // width: 200.w,
                width: double.maxFinite,
                height: 380.h,
                child: TabBarView(
                  physics: ScrollPhysics(),
                    controller: _tabBarController,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Select City",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kMainColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: Colors.grey.shade500),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: value,
                                  iconSize: 30.w,
                                  icon: Icon(Icons.arrow_drop_down,color: Colors.black),
                                  hint: Text("Select any city"),
                                  isExpanded: true,
                                  focusColor: Colors.grey.shade500,
                                  dropdownColor: kBackGroundColor,
                                  borderRadius: BorderRadius.circular(12.r),
                                  items: cities.map(buildMenuItem).toList(),
                                  onChanged: (value) => setState(() => this.value = value),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "Moving From",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kMainColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "Enter your building address or nearest landmark",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "Moving To",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kMainColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "Enter your building address or nearest landmark",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ElevatedButton(
                                onPressed: () => Fluttertoast.showToast(msg: "Pressed Elevated Button", fontSize: 16.sp),
                                child: Text("Check Prices"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(348.h, 50.w),
                                textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                onPrimary: Colors.white,
                                primary: kMainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Center(child: Icon(Icons.favorite_outlined, color: Colors.red.shade900,size: 400)),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.w, horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Moving From",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kMainColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "Enter your building address or nearest landmark",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "Moving To",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: kMainColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextField(
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "Enter your building address or nearest landmark",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            ElevatedButton(
                              onPressed: () => Fluttertoast.showToast(msg: "Pressed Elevated Button", fontSize: 16.sp),
                              child: Text("Check Prices"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(348.h, 50.w),
                                textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                onPrimary: Colors.white,
                                primary: kMainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                ),
              ),
              Text("How DryShades Packers & Movers work?",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 23.sp,
                  fontStyle: FontStyle.italic,
                  color: kMainColor,
                ),
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  child: Row(
                    children: [
                      Icon(Icons.laptop_mac_outlined,color: kMainColor,size: 25.sp,),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Share your Requirement",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: kMainColor,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Tell us where and when do you want to move",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: kMainColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  child: Row(
                    children: [
                      Icon(Icons.compare_arrows_rounded,color: kMainColor,size: 25.sp,),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get Free Instant Quote",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: kMainColor,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Get guaranteed lowest priced quote for your \nshifting instantly",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: kMainColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  child: Row(
                    children: [
                      Icon(Icons.schedule_outlined,color: kMainColor,size: 25.sp,),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Schedule and Confirm",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: kMainColor,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Pick a slot and pay a token amount to confirm \nyour move",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: kMainColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(15.w),
                  child: Row(
                    children: [
                      Icon(Icons.directions_car,color: kMainColor,size: 25.sp,),
                      SizedBox(width: 20.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We get you moved!",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: kMainColor,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "Our partner will arrive as per schedule to pack & \nload your belonging",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: kMainColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

