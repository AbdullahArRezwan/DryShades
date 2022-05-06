import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//rezu 01

class SocialButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  const SocialButton({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: FaIcon(
        icon,
        size: 16.w,
      ),
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          primary: Colors.white,
          shape: CircleBorder(),
          padding: EdgeInsets.all(18.w)),
    );
  }
}
