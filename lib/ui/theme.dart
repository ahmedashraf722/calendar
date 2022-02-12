import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: primaryClr,
    ),
    primaryColor: primaryClr,
    backgroundColor: primaryClr,
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
  );
  static final darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: primaryClr,
    ),
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
    primarySwatch: Colors.indigo,
  );

  static TextStyle get headingStyle {
    return GoogleFonts.montserrat(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get subHeadingStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get titleStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get subStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get bodyStyle {
    return GoogleFonts.montserrat(
      textStyle: const TextStyle(
        color: white,
        fontSize: 28.0,
      ),
    );
  }

  static TextStyle get inputTitleStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get titleTaskStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.grey[200],
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get titleBarStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get colorTaskStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get dropDownMenuStyle {
    return GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static TextStyle get dateStyle {
    return GoogleFonts.flamenco(
      textStyle: TextStyle(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
