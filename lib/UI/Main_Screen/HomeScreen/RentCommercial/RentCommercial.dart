import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:dry_shades/UI/Main_Screen/HomeScreen/RentCommercial/RentCommercialDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RentCommercial extends StatelessWidget {
  const RentCommercial({Key? key}) : super(key: key);

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
        title: Text("Rent Commercial",
          style: GoogleFonts.courgette(
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.none,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: kMainColor,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Rent-Commercial")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("Something went wrong"));
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: AnimatedTextKit(
                  animatedTexts: [
                    RotateAnimatedText('Loading',
                        textStyle: TextStyle(
                            fontSize: 40.sp,
                            fontFamily: "Horizon",
                            color: kMainColor)),
                  ],
                ),
              );
            else
              return Padding(
                padding: EdgeInsets.all(5.w),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot products = snapshot.data!.docs[index];
                    return ProductCard(
                      title: products["Name"],
                      price: products["Price"],
                      address: products["Address"],
                      imageUrl: products["Images"][0],
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => RentCommercialDetails(documentSnapshot: products))),
                    );
                  },
                ),
              );
          }),
    );
  }
  Widget ProductCard({imageUrl, title, price, address, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
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
                    image: NetworkImage(imageUrl),
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    child: InkWell(
                      onTap: onPressed,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 200.w,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5.w,
                      horizontal: 20.w,
                    ),
                    child: Text(
                      title,
                      textAlign: TextAlign.right,
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
                        address,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: kMainColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: kMainColor,
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
}
