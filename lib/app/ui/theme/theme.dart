import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueColor = Color(0xFF4e5ae8);
const Color yellowColor = Colors.deepOrange;
const Color pinkColor = Colors.pink;
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color darkHeaderColor = Color(0xFF424242);
const Color darkGreyColor = Color(0xFF121212);
const Color orangeColor = Colors.deepOrangeAccent;

class Themes {
  static final lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
          color: whiteColor,
          iconTheme: IconThemeData(color: Colors.black),
          actionsIconTheme: IconThemeData(color: Colors.black)),
      primaryIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      primaryColor: whiteColor,
      brightness: Brightness.light);
  static final darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(color: darkGreyColor),
      primaryColor: darkGreyColor,
      brightness: Brightness.dark);
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400]));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}
