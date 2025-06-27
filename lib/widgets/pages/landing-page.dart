import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-week-switcher.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule.dart';
import 'package:flutter_stream_schedule/widgets/socials/social-media-grid.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double stickyBarHeight = 80;
    return Stack(
      children: [
        Container (
          color: Colors.transparent,
        ),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              forceElevated: true,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: Stack(
                children: [
                  Container(
                    color: Theme.brightnessOf(context) == Brightness.light
                        ? AppThemeColors.light.accent.withAlpha(64)
                        : AppThemeColors.dark.accent.withAlpha(64),
                    height: stickyBarHeight,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 64.0, sigmaY: 64.0),
                    child: Container(height: stickyBarHeight),
                  ),
                  ScheduleWeekSwitcher(),
                ],
              ),
              titleSpacing: 0,
            ),
            SliverToBoxAdapter(child: Schedule()),
            SliverToBoxAdapter(child: SocialMediaGrid()),
          ],
        ),
      ],
    );
  }
}
