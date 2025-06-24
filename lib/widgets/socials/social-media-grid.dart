import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/widgets/socials/social-media-grid-item.dart';

class SocialMediaGrid extends StatelessWidget {

  const SocialMediaGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    List<SocialMediaItem> gridItems = [
      SocialMediaItem(
        label: "Twitch", 
        icon: "", 
        decoration: BoxDecoration(
              color: Color.fromARGB(255, 144, 70, 255)
          ),
        ),
      SocialMediaItem(
        label: "Discord", 
        icon: "", 
        decoration: BoxDecoration(
              color: Color.fromARGB(255, 88, 101, 242)
          ),
        )
    ];

    return GridView.count(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: gridItems.map((item) {
        return SocialMediaGridItem(
          item: item,
        );
      }).toList()
    );
  }
}
