import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color colorTeal = Colors.teal;
const Color colorBlack = Colors.black;
const Color colorWhite = Colors.white;
const Color colorRed = Colors.red;
const Color colorGry = Colors.grey;
const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {



  static final lightTheme = ThemeData(
    primaryColor: primaryClr,
    backgroundColor: colorWhite,
    brightness: Brightness.light,
  );
  static final darkTheme = ThemeData(
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
TextStyle get titleStyle{
  return GoogleFonts.cairo(
      textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?colorWhite:colorBlack
      )
  );
}