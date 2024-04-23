import 'package:flutter/material.dart';
import 'appColors.dart';

final ThemeData appTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.paleLime,
        brightness: Brightness.dark
    ),
    useMaterial3: true,
    fontFamily: "Satoshi",
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColors.raisinBlack,
    )
);
