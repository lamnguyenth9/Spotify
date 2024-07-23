import 'package:flutter/material.dart';
import 'package:spotify_app/core/config/themes/app_color.dart';

class AppTheme{
  static final lightTheme = ThemeData(
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.lightBackground,
     inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Color(0xff383838),
        fontWeight: FontWeight.w500
      ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.all(30),
        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(30),
           borderSide: BorderSide(
            color: Colors.black,
            width: 0.4
           )
        ),
        border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(30),
           borderSide: BorderSide(
            color: Colors.black,
            width: 0.4
           )
        )
      ),
    brightness: Brightness.light,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        )
      )
    )
  );
  static final darkTheme = ThemeData(
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.darkBackground,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w500
      ),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.all(30),
        enabledBorder: OutlineInputBorder(
          
           borderRadius: BorderRadius.circular(30),
           borderSide: BorderSide(
            color: Colors.white,
            width: 0.4
           )
        ),
        border: OutlineInputBorder(
           borderRadius: BorderRadius.circular(30),
           borderSide: BorderSide(
            color: Colors.white,
            width: 0.4
           )
        )
      ),
    brightness: Brightness.dark,
    fontFamily: 'Satoshi',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        )
      )
    )
  );

}