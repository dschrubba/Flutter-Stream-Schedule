import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';

class AppThemeFAB {

  AppThemeFAB._();

  static FloatingActionButtonThemeData get(Brightness brightness) {
    return FloatingActionButtonThemeData(
      backgroundColor: AppThemeColors.get(brightness).accent,
      foregroundColor: AppThemeColors.get(brightness).onAccent
    );
  }
  static FloatingActionButtonThemeData getLight() {
    return FloatingActionButtonThemeData(
      backgroundColor: AppThemeColors.get(Brightness.light).accent,
      foregroundColor: AppThemeColors.get(Brightness.light).onAccent
    );
  }
  static FloatingActionButtonThemeData getDark() {
    return FloatingActionButtonThemeData(
      backgroundColor: AppThemeColors.get(Brightness.light).accent,
      foregroundColor: AppThemeColors.get(Brightness.light).onAccent
    );
  }
}