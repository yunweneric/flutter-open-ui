import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color kdarkcolor = Color(0xFF191720);
Color kwhite = Colors.white;

TextStyle kplaceholder = TextStyle(color: Colors.grey, fontSize: 14.0.sp, fontWeight: FontWeight.w500);

TextStyle kheading1 = TextStyle(
  color: Colors.white,
  fontSize: 28.0.sp,
  height: 1.2.h,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w900,
);
TextStyle kheading2 = TextStyle(
  color: Colors.white,
  fontSize: 25.0.sp,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w400,
);
TextStyle kpara = TextStyle(
  color: Colors.white70,
  fontSize: 15.0.sp,
  fontFamily: 'poppins',
);

ButtonStyle kbtnstyl = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3A3941)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10.r),
        bottomRight: Radius.circular(10.r),
      ),
      side: BorderSide(color: Colors.transparent),
    ),
  ),
);
