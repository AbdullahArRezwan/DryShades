import 'package:dry_shades/UI/Constant_&_Customize_widget/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostDesign extends StatelessWidget {

  const PostDesign({Key? key, required this.title, required this.imageUrl, required this.address, required this.price}) : super(key: key);

  final String title;
  final String imageUrl;
  final String address;
  final String price;

  // void selectPost(BuildContext context){
  //   Navigator.of(context).pushNamed(
  //       PostDetailsScreen.routeName,
  //       arguments: title,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                  // child: Image.network(
                  //   imageUrl,
                  //   height: 200.h,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                  child: Ink.image(
                    image: NetworkImage(imageUrl),
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    child: InkWell(
                      onTap: () {},
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
                      title,
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
                    Row(
                      children: [
                        // Icon(Icons.money_off_csred_rounded),
                        Icon(Icons.attach_money_rounded,
                          color: kMainColor,
                        ),
                        SizedBox(width: 6.w),
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
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
