import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SVGIcon extends StatelessWidget {

  final String assetName;
  final Color  color;

  const SVGIcon({
    super.key,
    required this.assetName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: double.infinity,
      height: double.infinity,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcATop
        ),
      );
  }
}

