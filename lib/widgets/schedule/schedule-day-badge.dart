import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/globals.dart' as globals;
import 'package:flutter_stream_schedule/widgets/schedule/schedule.dart';

class ScheduleDayBadge extends StatelessWidget {
  final ScheduleItemState state;
  final int dateTs;
  final String day;
  final String hours;
  final String minutes;

  const ScheduleDayBadge({
    super.key,
    required this.day,
    required this.dateTs,
    required this.state,
    required this.hours,
    required this.minutes,
  });

  String getDayShort(String d) {
    return d.substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    Color textColor;
    bool isEmpty;

    switch (state) {
      case ScheduleItemState.accent:
        isEmpty = false;
        badgeColor = AppThemeColors.get(Theme.of(context).brightness).accent;
        textColor = AppThemeColors.get(Theme.of(context).brightness).onAccent;
        break;
      case ScheduleItemState.cancelled:
        isEmpty = false;
        badgeColor = AppThemeColors.get(
          Theme.of(context).brightness,
        ).surfaceDisabled;
        textColor = AppThemeColors.get(
          Theme.of(context).brightness,
        ).onSurfaceDisabled;
        break;
      case ScheduleItemState.empty:
        isEmpty = true;
        badgeColor = AppThemeColors.get(
          Theme.of(context).brightness,
        ).surfaceDisabled;
        textColor = AppThemeColors.get(
          Theme.of(context).brightness,
        ).onSurfaceDisabled;
        break;
    }

    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppThemeColors.shadowColor,
            offset: Offset(0, 10),
            blurRadius: globals.boxShadowBlur,
          ),
        ],
      ),
      height: !isEmpty ? globals.scheduleItemHeight : 80,
      // Outer padding for adjustment of the badge's position
      // Only horizontal padding should be used here!
      padding: EdgeInsets.symmetric(
        horizontal: globals.dayBadgeAdjustmentPadding,
        vertical: 0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.all(
          Radius.circular(globals.borderRadius),
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              child: ColoredBox(color: Colors.transparent),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              color: Color.lerp(
                Colors.transparent,
                badgeColor,
                globals.dayBadgeOpacity,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 2,
                children: [
                  Text(
                    "${dateTs.toString().substring(6, 8)}.${dateTs.toString().substring(4, 6)}",
                    style: CustomTextTheme().getStyleWithColor(
                      CustomTextTheme().monoLabelSmall,
                      textColor,
                    ),
                  ),
                  Text(
                    getDayShort(day),
                    style: CustomTextTheme().getStyleWithColor(
                      CustomTextTheme().monoLabelLarge,
                      textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
