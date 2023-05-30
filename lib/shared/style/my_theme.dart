import 'package:flutter/material.dart';

import 'color.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bkgColorGreen,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: colorBlack,
      secondary: bkgColorGreen,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.blue,
      background: bkgColorGreen,
      onBackground: primaryColor,
      surface: Colors.grey,
      onSurface: colorBlack,
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: colorBlack),
        subtitle2: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        shape: StadiumBorder(
            side: BorderSide(
          color: Colors.white,
          width: 4,
        ))),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bkgDarkColor,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: bkgDarkColor,
      onSecondary: navBkgDarkColor,
      error: colorRed,
      onError: colorBlue,
      background: bkgDarkColor,
      onBackground: primaryColor,
      surface: Colors.grey,
      onSurface: colorBlack,
    ),
    appBarTheme: const AppBarTheme(
      color: primaryColor,
      iconTheme: IconThemeData(color: colorBlack),
    ),
    textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        subtitle1: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        subtitle2: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        shape: StadiumBorder(side: BorderSide(color: colorBlack, width: 4))),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: navBkgDarkColor,
    ),
  );
}
