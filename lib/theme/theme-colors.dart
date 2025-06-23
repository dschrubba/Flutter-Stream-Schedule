import 'package:flutter/material.dart';

class AppThemeColors {
  AppThemeColors._();

  static AppThemeColorsSet light = AppThemeColorsSet(
    background: themeColors['bonestorm-100']!,
    onBackground: themeColors['moonlight-900']!,
    surface: themeColors['bonestorm-100']!,
    onSurface: themeColors['moonlight-900']!,
    surfaceDisabled: themeColors['nocturnal-800']!,
    onSurfaceDisabled: themeColors['nocturnal-400']!,
    accent: themeColors['lambda-600']!,
    onAccent: themeColors['bonestorm-100']!
  );

  static AppThemeColorsSet dark = AppThemeColorsSet(
    background: themeColors['nocturnal-900']!,
    onBackground: themeColors['bonestorm-100']!,
    surface: themeColors['moonlight-900']!,
    onSurface: themeColors['bonestorm-100']!,
    surfaceDisabled: themeColors['nocturnal-800']!,
    onSurfaceDisabled: themeColors['nocturnal-400']!,
    accent: themeColors['bakuretsuCrimson-600']!,
    onAccent: themeColors['bonestorm-100']!
  );

  static AppThemeColorsSet get(Brightness brightness) {
    if (brightness == Brightness.light) {
      return light;
    }
    else {
      return dark;
    }
  }
}

class AppThemeColorsSet {

  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceDisabled;
  final Color onSurfaceDisabled;
  final Color accent;
  final Color onAccent;
  static const Color fallback = Colors.amber;

  AppThemeColorsSet({
    this.background = fallback,
    this.onBackground = fallback,
    this.surface = fallback,
    this.onSurface = fallback,
    this.surfaceDisabled = fallback,
    this.onSurfaceDisabled = fallback,
    this.accent = fallback,
    this.onAccent = fallback,
  });
}

const Map<String, Color> themeColors = {
  'bakuretsuCrimson-50': Color.fromARGB(255, 254, 241, 248),
  'bakuretsuCrimson-100': Color.fromARGB(255, 254, 229, 243),
  'bakuretsuCrimson-200': Color.fromARGB(255, 255, 202, 234),
  'bakuretsuCrimson-300': Color.fromARGB(255, 255, 159, 214),
  'bakuretsuCrimson-400': Color.fromARGB(255, 255, 99, 185),
  'bakuretsuCrimson-500': Color.fromARGB(255, 254, 54, 156),
  'bakuretsuCrimson-600': Color.fromARGB(255, 239, 17, 119), // Base
  'bakuretsuCrimson-700': Color.fromARGB(255, 209, 5, 93),
  'bakuretsuCrimson-800': Color.fromARGB(255, 172, 8, 76),
  'bakuretsuCrimson-900': Color.fromARGB(255, 143, 12, 67),
  'bakuretsuCrimson-950': Color.fromARGB(255, 88, 0, 35),
  'lambda-50': Color.fromARGB(255, 255, 248, 236),
  'lambda-100': Color.fromARGB(255, 255, 240, 211),
  'lambda-200': Color.fromARGB(255, 255, 220, 165),
  'lambda-300': Color.fromARGB(255, 255, 194, 109),
  'lambda-400': Color.fromARGB(255, 255, 157, 50),
  'lambda-500': Color.fromARGB(255, 255, 127, 10),
  'lambda-600': Color.fromARGB(255, 255, 102, 0), // Base
  'lambda-700': Color.fromARGB(255, 204, 73, 2),
  'lambda-800': Color.fromARGB(255, 161, 57, 11),
  'lambda-900': Color.fromARGB(255, 130, 49, 12),
  'lambda-950': Color.fromARGB(255, 70, 22, 4),
  'moonlight-50': Color.fromARGB(255, 245, 247, 250),
  'moonlight-100': Color.fromARGB(255, 233, 236, 245),
  'moonlight-200': Color.fromARGB(255, 207, 216, 232),
  'moonlight-300': Color.fromARGB(255, 164, 182, 213),
  'moonlight-400': Color.fromARGB(255, 116, 144, 188),
  'moonlight-500': Color.fromARGB(255, 82, 114, 165),
  'moonlight-600': Color.fromARGB(255, 63, 90, 138),
  'moonlight-700': Color.fromARGB(255, 52, 73, 112),
  'moonlight-800': Color.fromARGB(255, 46, 63, 94),
  'moonlight-900': Color.fromARGB(255, 41, 53, 77), // Base
  'moonlight-950': Color.fromARGB(255, 28, 36, 53),
  'nocturnal-50': Color.fromARGB(255, 235, 235, 239),
  'nocturnal-100': Color.fromARGB(255, 221, 221, 228),
  'nocturnal-200': Color.fromARGB(255, 192, 192, 206),
  'nocturnal-300': Color.fromARGB(255, 164, 164, 183),
  'nocturnal-400': Color.fromARGB(255, 135, 135, 161),
  'nocturnal-500': Color.fromARGB(255, 108, 108, 137),
  'nocturnal-600': Color.fromARGB(255, 86, 86, 108),
  'nocturnal-700': Color.fromARGB(255, 63, 63, 80),
  'nocturnal-800': Color.fromARGB(255, 41, 41, 51),
  'nocturnal-900': Color.fromARGB(255, 18, 18, 23), // Base
  'nocturnal-950': Color.fromARGB(255, 7, 7, 9),
  'bonestorm-50': Color.fromARGB(255, 250, 253, 252),
  'bonestorm-100': Color.fromARGB(255, 242, 245, 244), // Base
  'bonestorm-200': Color.fromARGB(255, 213, 223, 220),
  'bonestorm-300': Color.fromARGB(255, 184, 201, 196),
  'bonestorm-400': Color.fromARGB(255, 155, 179, 172),
  'bonestorm-500': Color.fromARGB(255, 126, 157, 148),
  'bonestorm-600': Color.fromARGB(255, 100, 132, 123),
  'bonestorm-700': Color.fromARGB(255, 78, 103, 96),
  'bonestorm-800': Color.fromARGB(255, 56, 74, 69),
  'bonestorm-900': Color.fromARGB(255, 34, 45, 42),
  'bonestorm-950': Color.fromARGB(255, 23, 30, 28),
};