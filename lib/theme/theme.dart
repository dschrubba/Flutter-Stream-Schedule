import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-fab.dart';

class AppTheme {
  BuildContext context;
  AppTheme._(this.context);
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: customFontFamilyNames[CustomFontFamilies.generalSans],
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppThemeColors.light.background,
    // Custom Widget Themes
    textTheme: CustomTextTheme(),
    floatingActionButtonTheme: AppThemeFAB.getLight()
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppThemeColors.dark.background,
    // Custom Widget Themes
    textTheme: CustomTextTheme(),
    floatingActionButtonTheme: AppThemeFAB.getDark()
  );
  static ThemeData getTheme(BuildContext ctx) {
    if (Theme.of(ctx).brightness == Brightness.light) {
      return lightTheme;
    }
    else {
      return darkTheme;
    }
  }
}