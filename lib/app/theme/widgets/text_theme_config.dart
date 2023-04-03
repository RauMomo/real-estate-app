import 'package:flutter/material.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';
import 'package:real_estate_app/shared/util/conversion.dart';

TextTheme textThemeConfig() {
  return TextTheme(
    //appbar title
    headlineSmall: TextStyle(
      fontFamily: 'SF Pro Display',
      color: ColorConstants.kDark,
      fontSize: 12,
      letterSpacing: 1.0,
      height: pxToDouble(
        px: kLightLineHeight,
      ),
      fontWeight: FontWeight.w700,
    ),
    //card title
    headlineMedium: TextStyle(
      fontFamily: 'SF Pro Display',
      color: ColorConstants.kDark,
      fontSize: 16,
      height: pxToDouble(
        px: kNormalLineHeight,
      ),
      fontWeight: FontWeight.w700,
    ),
    //card detail title
    headlineLarge: TextStyle(
      fontFamily: 'SF Pro Display',
      color: ColorConstants.kDark,
      fontSize: 22,
      height: pxToDouble(
        px: kLargeLineHeight,
      ),
      fontWeight: FontWeight.w700,
    ),
    //attribute
    titleMedium: TextStyle(
      fontFamily: 'SF Pro Display',
      color: ColorConstants.kDark,
      fontSize: 14,
      height: pxToDouble(
        px: kLightLineHeight,
      ),
      fontWeight: FontWeight.normal,
    ),
    //booking price button
    displayMedium: TextStyle(
      fontFamily: 'SF Pro Display',
      color: ColorConstants.kDark,
      fontSize: 14,
      height: pxToDouble(
        px: kLightLineHeight,
      ),
      fontWeight: FontWeight.normal,
    ),
  );
}
