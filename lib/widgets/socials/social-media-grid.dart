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
        iconAssetName: "assets/socials/twitch.svg", 
        envUri: "SOCIALS_TWITCH",
        color: Color.fromARGB(255, 144, 70, 255)
        ),
      SocialMediaItem(
        label: "Discord", 
        iconAssetName: "assets/socials/discord.svg", 
        envUri: "SOCIALS_DISCORD",
        color: Color.fromARGB(255, 88, 101, 242)
        ),
      SocialMediaItem(
        label: "Bluesky", 
        iconAssetName: "assets/socials/bluesky.svg", 
        envUri: "SOCIALS_BLUESKY",
        color: Color.fromARGB(255, 11, 135, 254)
        ),
      SocialMediaItem(
        label: "Steam", 
        iconAssetName: "assets/socials/steam.svg", 
        envUri: "SOCIALS_STEAM",
        color: Color.fromARGB(255, 0, 0, 0)
        ),
      SocialMediaItem(
        label: "YouTube", 
        iconAssetName: "assets/socials/youtube.svg", 
        envUri: "SOCIALS_YOUTUBE",
        color: Color.fromARGB(255, 255, 0, 0)
        ),
      SocialMediaItem(
        label: "YouTube VODs", 
        iconAssetName: "assets/socials/youtube.svg", 
        envUri: "SOCIALS_YOUTUBE_VODS",
        color: Color.fromARGB(255, 255, 0, 0)
        ),
      SocialMediaItem(
        label: "SoundCloud", 
        iconAssetName: "assets/socials/soundcloud.svg", 
        envUri: "SOCIALS_SOUNDCLOUD",
        color: Color.fromARGB(255, 242, 111, 35)
        ),
      SocialMediaItem(
        label: "Spotify", 
        iconAssetName: "assets/socials/spotify.svg",
        envUri: "SOCIALS_SPOTIFY",
        color: Color.fromARGB(255, 30, 215, 96),
        overridePadding: EdgeInsets.all(14)
        )
    ];

    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: GridView.count(
        shrinkWrap: true,
        // Create a grid with 2 columns.
        // If you change the scrollDirection to horizontal,
        // this produces 2 rows.
        scrollDirection: Axis.vertical,
        crossAxisCount: 4,
        // Generate 100 widgets that display their index in the list.
        children: List.generate(gridItems.length, (index) {
          return Center(
            child: SocialMediaGridItem(
              item: gridItems[index],
            )
          );
        }),
      )
    );
  
  }
}
