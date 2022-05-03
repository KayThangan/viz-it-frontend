import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';

enum AppTheme { LIGHT, DARK }

String enumName(AppTheme anyEnum) {
  return anyEnum.toString();
}

final appThemeData = {
  AppTheme.LIGHT: ThemeData.light().copyWith(
    backgroundColor: Color(0xfff7f6fb),
    primaryColor: Color(0xff3c3c4c),
    hintColor: Color(0xffa2a3aa),
    accentColor: Color(0xfff5f7fb),
    canvasColor: Colors.white,

    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        color: Color(0xff3c3c4c),
        fontStyle: FontStyle.normal,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
        bodyLarge: GoogleFonts.poppins(
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontSize: 32,
          fontWeight: FontWeight.w600,
        )
    ),
  ),
  AppTheme.DARK: ThemeData(
    // textTheme: GoogleFonts.latoTextTheme(),
  ),
};
