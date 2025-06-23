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
  final double height;

  const ScheduleDayBadge({
    super.key, required this.day, required this.height, required this.dateTs, required this.state
  });

  String getDayShort(String d) {
    return d.substring(0,2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {

    Color badgeColor;
    Color textColor;

    switch (state) {
      case ScheduleItemState.accent:
        badgeColor = AppThemeColors.get(Theme.of(context).brightness).accent;
        textColor = AppThemeColors.get(Theme.of(context).brightness).onAccent;
        break;
      case ScheduleItemState.cancelled:
        badgeColor = AppThemeColors.get(Theme.of(context).brightness).surfaceDisabled;
        textColor = AppThemeColors.get(Theme.of(context).brightness).onSurfaceDisabled;
        break;
      case ScheduleItemState.empty:
        badgeColor = AppThemeColors.get(Theme.of(context).brightness).surfaceDisabled;
        textColor = AppThemeColors.get(Theme.of(context).brightness).onSurfaceDisabled;
        break;
    }

    return ConstrainedBox(
      constraints: 
        BoxConstraints(
          maxWidth: globals.dayBadgeWidth + globals.dayBadgeAdjustmentPadding,
        ),
        child: Container(
          // Outer padding for adjustment of the badge's position
          // Only horizontal padding should be used here!
          padding: 
            EdgeInsets.symmetric(
              horizontal: globals.dayBadgeAdjustmentPadding,
              vertical: 0
            ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(globals.borderRadius)),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: SizedBox.expand(
                    child: ColoredBox(color: Colors.transparent),
                  ),
                ),
                SizedBox.expand(
                  child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14
                  ),
                  color: Color.lerp(Colors.transparent, badgeColor, globals.dayBadgeOpacity),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${dateTs.toString().substring(6,8)}.${dateTs.toString().substring(4,6)}", 
                        style: CustomTextTheme().getStyleWithColor(CustomTextTheme().monoLabelSmall, textColor)
                      ),
                      Text(
                        getDayShort(day), 
                        style: CustomTextTheme().getStyleWithColor(CustomTextTheme().monoLabelLarge, textColor)
                      ),
                    ]
                  ),
                )
                ),
              ],
            )
          )
        )
    );
  }
}
