import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/svg-icon.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: FilledButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((Set<WidgetState> states) => item.color)
          ),
        onPressed: () => {
          _launchURL(dotenv.env[item.envUri] ?? '#')
        },
            child: Center(
              child: SVGIcon(
                assetName: item.iconAssetName, 
                color: themeColors["bonestorm-100"]!
          )
        )
      )
    );
  }

  _launchURL(String url) async {
   final parsed = Uri.parse(url);
   if (!await launchUrl(
    parsed,
    mode: LaunchMode.externalApplication
    )) {
        throw Exception('Could not launch $parsed');
    }
}
}

class SocialMediaItem {
  final String label;
  final String iconAssetName;
  final Color color;
  final String envUri;
  final EdgeInsetsGeometry? overridePadding;

  SocialMediaItem({
    required this.label,
    required this.iconAssetName,
    required this.color,
    required this.envUri,
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