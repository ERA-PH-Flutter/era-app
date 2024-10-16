import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';

class MyTheme {
  static getDefault() {
    return ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
        dialogBackgroundColor: Colors.transparent,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.white));
  }
}
