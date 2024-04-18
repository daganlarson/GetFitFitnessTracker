import 'package:flutter/material.dart';
import 'appColors.dart';

class AppTheme {

  static const colors = AppColors();

  const AppTheme._();
  static ThemeData define() {
    return ThemeData(
      fontFamily: "Satoshi",
      primaryColor: Color(0xffd5ff5f),

    );
  }
}

class GetFitColorScheme extends ColorScheme {
  const GetFitColorScheme({
    required super.brightness,
    required super.primary,
    required super.onPrimary,
    required super.secondary,
    required super.onSecondary,
    required super.error,
    required super.onError,
    required super.background,
    required super.onBackground,
    required super.surface,
    required super.onSurface
  });

}