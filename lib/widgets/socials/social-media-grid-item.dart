import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/svg-icon.dart';

class SocialMediaGridItem extends StatelessWidget {

  final SocialMediaItem item;

  const SocialMediaGridItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16), 
      child: ClipOval(
        child: ColoredBox(
          color: item.color, 
          child: Padding(
            padding: (item.overridePadding != null) ? item.overridePadding! : EdgeInsetsGeometry.all(10), 
            child: Center(
              child: SVGIcon(
                assetName: item.iconAssetName, 
                color: themeColors["bonestorm-100"]!
              )
            )
          )
        )
      ),
    );
  }
}

class SocialMediaItem {
  final String label;
  final String iconAssetName;
  final Color color;
  final EdgeInsetsGeometry? overridePadding;

  SocialMediaItem({
    required this.label,
    required this.iconAssetName,
    required this.color,
    this.overridePadding
  });
}

/*
SvgClip(
asset: ClipAsset.local(path: "assets/images/cloud.svg"),
child: const _ColoredBox(
   color: Colors.green,
   width: 300,
   height: 100,
 ),
)


*/