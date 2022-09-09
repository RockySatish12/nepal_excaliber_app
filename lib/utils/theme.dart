import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme() {
    return ThemeData.light()
        .textTheme
        .copyWith(
          titleLarge: const TextStyle(
              fontFamily: "ZillaSlab",
              fontWeight: FontWeight.w700,
              fontSize: 20),
          titleMedium: const TextStyle(
              fontFamily: "ZillaSlab",
              fontWeight: FontWeight.w700,
              fontSize: 18),
          titleSmall: const TextStyle(
              fontFamily: "ZillaSlab",
              fontWeight: FontWeight.w700,
              fontSize: 16),
          bodyLarge: const TextStyle(
              fontFamily: "ZillaSlab",
              fontWeight: FontWeight.w500,
              fontSize: 16),
          bodyMedium: const TextStyle(
              fontFamily: "ZillaSlab",
              fontWeight: FontWeight.w400,
              fontSize: 16),
          bodySmall: const TextStyle(
              fontFamily: "ZillaSlab",
              fontWeight: FontWeight.w300,
              fontSize: 16),
        )
        .apply(
            bodyColor: AppColors.textColor,
            displayColor: AppColors.textColor,
            fontFamily: "ZillaSlab");
  }

  return ThemeData.light().copyWith(
      textTheme: _basicTextTheme(),
      colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          tertiary: AppColors.tertiaryColor,
          outline: AppColors.borderColor,
          onError: AppColors.errorColor),
      scaffoldBackgroundColor: AppColors.backGroundColor,
      hintColor: AppColors.hintTextColor,
      errorColor: AppColors.errorColor,
      backgroundColor: AppColors.backGroundColor);
}
