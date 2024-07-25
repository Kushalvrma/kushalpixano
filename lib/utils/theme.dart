import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ThemeData appPrimaryTheme = ThemeData(
  fontFamily: 'Roboto',
  iconTheme: const IconThemeData(),

  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 21.sp, //28 done
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    ),
    titleMedium: TextStyle(
      fontSize: 23.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    titleSmall: TextStyle(
      fontSize: 16.sp,  // 22 done
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    headlineLarge: TextStyle(
      fontSize: 13.sp,  //18 done
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    headlineMedium: TextStyle(
      fontSize: 10.5.sp,  // 14/done
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    headlineSmall: TextStyle(
      fontSize: 12.sp, //16 done
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.75.sp,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(fontSize: 17.25.sp, fontWeight: FontWeight.w500, fontStyle: FontStyle.normal),
    bodySmall: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, fontStyle: FontStyle.normal),
    labelLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    labelMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    labelSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    displayLarge: TextStyle(
      fontSize: 10.sp,  // 14done
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    displayMedium: TextStyle(
      fontSize: 18.25.sp,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
    ),
    displaySmall: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  ),
);
