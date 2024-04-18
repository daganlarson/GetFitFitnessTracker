import 'package:flutter/material.dart';
import 'appColors.dart';

final ThemeData appTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: AppColors.paleLime,
      tertiary: AppColors.pinkAccent,
      background: AppColors.raisinBlack,
      brightness: Brightness.dark,
      onPrimary: AppColors.outerSpace,
      secondary: AppColors.pinkAccent,
      onSecondary: AppColors.outerSpace,
      error: AppColors.pinkAccent,
      onError: AppColors.raisinBlack,
      onBackground: AppColors.paleLime,
      surface: AppColors.raisinBlack,
      onSurface: AppColors.paleLime,
    ),
    useMaterial3: true,
    fontFamily: "Satoshi",
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.raisinBlack,
    )
);