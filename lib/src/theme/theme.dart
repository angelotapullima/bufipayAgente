import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final bufiPayThemeLight = ThemeData.light().copyWith(
  textTheme: GoogleFonts.mulishTextTheme(),
  scaffoldBackgroundColor: BufiPayColors.whiteColor,
  textSelectionTheme: TextSelectionThemeData(selectionColor: BufiPayColors.greenColor),
  brightness: Brightness.light,
);
final bufiPayThemeDark = ThemeData.light().copyWith(
  textTheme: GoogleFonts.mulishTextTheme(),
  scaffoldBackgroundColor: BufiPayColors.darkBlue,
  textSelectionTheme: TextSelectionThemeData(selectionColor: BufiPayColors.greenColor),
  brightness: Brightness.light,
);

class BufiPayColors {
  static final Color darkBlue = Color(0xFF130C42);
  static final Color greenColor = Color(0xFF5FF558);
  static final Color whiteColor = Color(0xFFFFFFFF);
}
