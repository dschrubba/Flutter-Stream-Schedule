import 'package:flutter/material.dart';

class SocialMediaGridItem extends StatelessWidget {

  final SocialMediaItem item;

  const SocialMediaGridItem({
    super.key,
    required this.item
  });

  @override
  Widget build(BuildContext context) {
  
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.teal[100],
      child: Text(item.label)
    );
  }
}

class SocialMediaItem {
  final String label;
  final String icon;
  final Decoration decoration;

  SocialMediaItem({
    required this.label,
    required this.icon,
    required this.decoration,
  });
}