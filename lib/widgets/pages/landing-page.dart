import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule.dart';
import 'package:flutter_stream_schedule/widgets/socials/social-media-grid.dart';

class LandingPage extends StatelessWidget {

  const LandingPage({
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox (
      child: Column (
        children: [
          SizedBox(
            width: double.infinity,
            child: Schedule()
          ),
          SizedBox(
            width: double.infinity,
            child: SocialMediaGrid()
          ),
        ],
      )
    );
  }
}
