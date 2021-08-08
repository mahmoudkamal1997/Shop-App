import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/style/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontSize: 24.0,
        color: Colors.black,
        fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey[500],
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
      headline6: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.w600)),
  fontFamily: 'jannah'
);

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
  backwardsCompatibility: false,
  systemOverlayStyle: SystemUiOverlayStyle(
  statusBarColor: HexColor('333739'),
  statusBarIconBrightness: Brightness.light),
  backgroundColor: HexColor('333739'),
  elevation: 0.0,
  titleTextStyle: TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontWeight: FontWeight.bold),
  iconTheme: IconThemeData(
  color: Colors.white,
  ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
  backgroundColor: defaultColor ,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: HexColor('333739'),
  type: BottomNavigationBarType.fixed,
  elevation: 30.0,
  selectedItemColor: defaultColor,
  unselectedItemColor: Colors.grey[500]),
  textTheme: TextTheme(
  headline6: TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.w600)),
  fontFamily: 'jannah'
  );

