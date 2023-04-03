import 'package:flutter/material.dart';
import 'package:real_estate_app/app/theme/widgets/app_bar_theme_config.dart';
import 'package:real_estate_app/app/theme/widgets/text_theme_config.dart';
import 'package:real_estate_app/shared/constants/colors.dart';

class ThemeService {
  static ThemeData buildNormalMode(context) {
    return ThemeData(
      appBarTheme: appBarThemeConfig(context),
      textTheme: textThemeConfig(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ColorConstants.kPrimary,
          foregroundColor: ColorConstants.kLightGrey200,
          visualDensity: const VisualDensity(vertical: -4, horizontal: 1),
          fixedSize: const Size.fromHeight(36),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: textThemeConfig()
              .displayMedium!
              .copyWith(color: Colors.white, height: 1.3),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: ColorConstants.kWhite,
          fixedSize: const Size.fromHeight(30),
          textStyle: textThemeConfig().displayMedium!.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold, height: 1.3),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(color: ColorConstants.kLightGrey, width: 1.2)),
        ),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: ColorConstants.kPrimary,
        onPrimary: ColorConstants.kPrimary200,
        error: ColorConstants.kError,
        onError: ColorConstants.kError200,
        background: ColorConstants.kLightGrey,
        onBackground: ColorConstants.kLightGrey200,
        secondary: ColorConstants.kSuccess,
        onSecondary: ColorConstants.kSuccess200,
        surface: ColorConstants.kWhite,
        onSurface: ColorConstants.kWhite,
        errorContainer: ColorConstants.kError600,
        tertiary: ColorConstants.kDark,
        onTertiary: ColorConstants.kDark200,
      ),
      primaryColor: ColorConstants.kPrimary,
    );
  }

  static ThemeData buildDarkMode() {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: ColorConstants.kPrimary,
        onPrimary: ColorConstants.kPrimary200,
        error: ColorConstants.kError,
        onError: ColorConstants.kError200,
        background: ColorConstants.kLightGrey,
        onBackground: ColorConstants.kLightGrey200,
        secondary: ColorConstants.kSuccess,
        onSecondary: ColorConstants.kSuccess200,
        surface: ColorConstants.kWhite,
        onSurface: ColorConstants.kWhite,
        errorContainer: ColorConstants.kError600,
        tertiary: ColorConstants.kDark,
        onTertiary: ColorConstants.kDark200,
      ),
      primaryColor: ColorConstants.kPrimary,
    );
  }
}
