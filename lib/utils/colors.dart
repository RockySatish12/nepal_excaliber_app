import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF000000);
  static const secondaryColor = Color(0xFFFFFFFF);
  static const tertiaryColor = Color(0xFF4267B2);
  static const backGroundColor = Color(0xFFF5F7F9);
  static const borderColor = Color(0xFFDADCE0);
  static const textColor = Color(0xFF000000);
  static const textColorAccent = Color(0xFFFFFFFF);
  static const hintTextColor = Color(0xFF7D7D7D);
  static const errorColor = Color(0XFFC1272D);
  static final shimmerBase = Colors.grey.withOpacity(0.40);
  static const Color shimmerHighlight = Color(0xFFE1E1E1);

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
