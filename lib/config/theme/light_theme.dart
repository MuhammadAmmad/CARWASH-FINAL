// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';

final ThemeData LightTheme = ThemeData(
  scaffoldBackgroundColor: kSecondaryColor,
  fontFamily: AppFonts.Montserrat,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: kSecondaryColor,
  ),
  splashColor: kTertiaryColor.withOpacity(0.10),
  highlightColor: kTertiaryColor.withOpacity(0.10),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: kPrimaryColor.withOpacity(0.1),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: kPrimaryColor,
  ),
);
