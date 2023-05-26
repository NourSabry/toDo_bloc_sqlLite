import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_algoriza/core/util/style/colors.dart';

ThemeData lightthemes = ThemeData(
  // primarySwatch: Colors.brown,
  scaffoldBackgroundColor: Colors.white,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
  iconTheme: IconThemeData(color: Colors.grey, size: 25),
  appBarTheme: const AppBarTheme(
    titleSpacing: 25,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 1,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: defultColor,
    unselectedLabelColor: Colors.grey,
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(width: 3, color: defultColor),
        insets: EdgeInsets.symmetric(horizontal: 30)),
    labelPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 3),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    displayLarge: TextStyle(
      fontSize: 30,
      color: Colors.black54,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w300,
      color: Color(0xFF8D8E98),
    ),
  ),
);
