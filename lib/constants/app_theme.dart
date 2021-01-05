import 'package:swallowing_app/constants/colors.dart';
import 'package:swallowing_app/constants/font_family.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.kanit,
    brightness: Brightness.light,
    primaryColor: AppColors.deepblue,
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.lightgray,
    accentColorBrightness: Brightness.light
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.kanit,
  brightness: Brightness.dark,
  primaryColor: AppColors.deepblue,
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.lightgray,
  accentColorBrightness: Brightness.dark,
);