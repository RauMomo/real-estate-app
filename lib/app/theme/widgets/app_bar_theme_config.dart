import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_app/app/theme/widgets/text_theme_config.dart';
import 'package:real_estate_app/shared/constants/colors.dart';
import 'package:real_estate_app/shared/constants/ui_size_constants.dart';

appBarThemeConfig(context) {
  final TextTheme textTheme = textThemeConfig();
  final toolbarHeight = screenHeight(context) * .117;
  final colorTheme = ColorConstants.kPrimary;
  return AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemStatusBarContrastEnforced: true),
      toolbarHeight: toolbarHeight,
      color: colorTheme,
      elevation: 0,
      titleTextStyle: textTheme.headlineSmall);
}
