import 'package:flutter/material.dart';

class CustomTextTheme extends TextTheme {

  final TextStyle scheduleItemGameTitle = TextStyle(
    fontFamily: customFontFamilyNames[CustomFontFamilies.generalSans],
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w200,
    height: 1
  );

  final TextStyle scheduleItemGameSubTitle = TextStyle(
    fontFamily: customFontFamilyNames[CustomFontFamilies.generalSans],
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1
  );

  final TextStyle scheduleItemStreamTitle = TextStyle(
    fontFamily: customFontFamilyNames[CustomFontFamilies.generalSans],
    fontSize: 14,
    fontWeight: FontWeight.w200,
    height: 1
  );

  final TextStyle monoLabelLarge = TextStyle(
    fontFamily: customFontFamilyNames[CustomFontFamilies.ibmPlexMono],
    fontSize: 36,
    fontWeight: FontWeight.w600,
    height: 1
  );

  final TextStyle monoLabelSmall = TextStyle(
    fontFamily: customFontFamilyNames[CustomFontFamilies.ibmPlexMono],
    fontSize: 14,
    fontWeight: FontWeight.w800,
    height: 1
  );

  CustomTextTheme() : super(
    labelLarge:  TextStyle(
      fontFamily: customFontFamilyNames[CustomFontFamilies.generalSans],
      fontSize: 24,
      fontWeight: FontWeight.w700
    )
  );

  TextStyle getStyleWithColor(TextStyle textStyle, Color color) {
    return textStyle.copyWith(color: color);
  }

  TextStyle getStyle(CustomFontFamilies font) {
    // Generate font variations
    List<FontVariation> variations = [];
    FontWeight.values.map((weight) => variations.add(
      FontVariation('wght', ((weight.index + 1) * 100).toDouble())
    ));
    // Bang operator used since Enum assures existence of font value
    String fontFamily = customFontFamilyNames[font]!;
    return TextStyle(
        fontFamily: fontFamily,
        fontVariations: variations
      );
  }
}

// Font Family names refer to pubspec.yaml
const Map<CustomFontFamilies, String> customFontFamilyNames = {
  CustomFontFamilies.generalSans: "General Sans",
  CustomFontFamilies.ibmPlexMono: "IBM Plex Mono",
};

// Enum for font selection
enum CustomFontFamilies {
  generalSans,
  ibmPlexMono
}

