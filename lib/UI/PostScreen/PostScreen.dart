import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import './Dummy_Data.dart';
import 'AllPostScreen.dart';

class PostScreen extends StatelessWidget {
  static const postScreenRouteName = '/post-screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryDetails = Dummy_CategoryDetails.where((post) {
      return post.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xfff7f6fb),
        iconTheme: IconThemeData(
          color: Color(0xff072A6C),
        ),
        title: Text(categoryTitle!,
          style: GoogleFonts.zenKurenaido(
            fontStyle: FontStyle.normal,
            decoration: TextDecoration.none,
            fontSize: 30.sp,
            fontWeight: FontWeight.w900,
            color: Color(0xff072A6C),
          ),
        ),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return PostDesign(title: categoryDetails[index].title, imageUrl: categoryDetails[index].imageUrl, address: categoryDetails[index].address, price: categoryDetails[index].price);
      },
        itemCount: categoryDetails.length,
      ),
    );
  }
}

