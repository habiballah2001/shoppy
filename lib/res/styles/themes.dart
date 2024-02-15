import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[850],
    primaryColor: Colors.orange,
    primarySwatch: Colors.orange,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      titleSpacing: 20.0,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: DarkColors.textColor,
        //fontSize: 20.0,
        //fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: DarkColors.textColor,
      ),
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey.shade100,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[900],
    ),
    cardColor: DarkColors.cardColor,
    iconTheme: const IconThemeData(color: DarkColors.textColor),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      overlayColor: MaterialStateProperty.all(Colors.orange.shade100),
    )),
/*
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        //fontSize: 22.0,
        //fontWeight: FontWeight.w600,
        color: DarkColors.textColor,
      ),
      titleMedium: TextStyle(
        //fontSize: 20.0,
        //fontWeight: FontWeight.w500,
        color: DarkColors.textColor,
      ),
      titleSmall: TextStyle(
        //fontSize: 16.0,
        //fontWeight: FontWeight.w400,
        color: DarkColors.textColor,
      ),
      bodyLarge: TextStyle(
        //fontSize: 16.0,
        //fontWeight: FontWeight.w400,
        color: DarkColors.textColor,
        //height: 1.8,
      ),
      bodyMedium: TextStyle(
        //fontSize: 14,
        //fontWeight: FontWeight.w400,
        color: DarkColors.textColor,
        //height: 1.8,
      ),
      bodySmall: TextStyle(
        //fontSize: 12,
        //fontWeight: FontWeight.w400,
        color: DarkColors.textColor,
        //height: 1.8,
      ),
    ),
*/
    fontFamily: 'Jannah',
  );
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: LightColors.bgColor,
    primaryColor: Colors.deepOrange,
    primarySwatch: Colors.deepOrange,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: LightColors.bgColor,
      iconTheme: IconThemeData(
        color: Colors.black54,
        size: 25,
      ),
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: LightColors.textColor,
        //fontSize: 20.0,
        //fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primaryColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
    ),
    cardColor: LightColors.cardColor,
    iconTheme: IconThemeData(
      color: Colors.grey.shade600,
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.black54),
      overlayColor: MaterialStateProperty.all(Colors.orange.shade100),
    )),
/*
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          //fontSize: 22.0,
          //fontWeight: FontWeight.w600,
          //color: LightColors.textColor,
          ),
      titleMedium: TextStyle(
          //fontSize: 20.0,
          //fontWeight: FontWeight.w500,
          //color: LightColors.textColor,
          ),
      titleSmall: TextStyle(
          //fontSize: 16.0,
          //fontWeight: FontWeight.w400,
          //color: LightColors.textColor,
          ),
      bodyLarge: TextStyle(
        //fontSize: 16.0,
        //fontWeight: FontWeight.w400,
        color: LightColors.textColor,
        //height: 1.8,
      ),
      bodyMedium: TextStyle(
          //fontWeight: FontWeight.w400,
          ),
      bodySmall: TextStyle(
          //fontWeight: FontWeight.w400,
          ),
    ),
*/
    fontFamily: 'Jannah',
  );
}
