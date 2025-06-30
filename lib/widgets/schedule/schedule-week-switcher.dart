import 'dart:developer';

import 'package:flutter_stream_schedule/providers.dart';
import 'package:flutter_stream_schedule/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScheduleWeekSwitcher extends ConsumerStatefulWidget {

  const ScheduleWeekSwitcher({
    super.key
    });

  @override
  ConsumerState<ScheduleWeekSwitcher> createState() => _ScheduleWeekSwitcherState();
}

class _ScheduleWeekSwitcherState extends ConsumerState<ScheduleWeekSwitcher> {

  String buildDateRangeString(int y, int cw) {
    List<DateTime> days = Utils.datesOfCalendarWeek(y, cw);
    String firstDay = Utils.getFormattedDate(days[0]);
    String lastDay  = Utils.getFormattedDate(days[days.length - 1]);
    return "$firstDay  bis  $lastDay"; 
  }

  @override
  Widget build(BuildContext context) {
    log("_ScheduleWeekSwitcherState:build called");

    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateColor.resolveWith((c) => AppThemeColors.get(Theme.of(context).brightness).accent),
      textStyle: WidgetStateTextStyle.resolveWith((t) => TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      )
    );

    return Container(
      decoration: BoxDecoration(
        color: AppThemeColors.get(Theme.brightnessOf(context)).accent.withAlpha(64),
        backgroundBlendMode: 
          Theme.brightnessOf(context) == Brightness.light
          ? BlendMode.screen
          : BlendMode.multiply
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton.filled(
                onPressed: () => {
                  ref.read(calendarWeekProvider).decrementWeek()
                },
                style: buttonStyle,
                icon: 
                  Icon(
                    Icons.chevron_left,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  color: AppThemeColors.get(Theme.of(context).brightness).onAccent,
              ),
              FilledButton(
                onPressed: () => {
                  ref.read(calendarWeekProvider).setBothToCurrent()
                },
                style: buttonStyle,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 0, horizontal: 4),
                  child: Text(
                    buildDateRangeString(
                      ref.watch(calendarWeekProvider).calendarYear,
                      ref.watch(calendarWeekProvider).calendarWeek
                      ), 
                    style: CustomTextTheme().getStyle(CustomFontFamilies.generalSans).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppThemeColors.get(Theme.of(context).brightness).onAccent
                      ),
                    )
              )),
              IconButton.filled(
                onPressed: () => {
                  ref.watch(calendarWeekProvider).incrementWeek()
                  },
                style: buttonStyle,
                icon: 
                  Icon(
                    Icons.chevron_right,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  color: AppThemeColors.get(Theme.of(context).brightness).onAccent,
              )
            ]
          )
        )
      )
    );
  }
}

class StickyScheduleWeekSwitcherDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 4.0 : 0.0,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: const ScheduleWeekSwitcher(),
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // Rebuild only if the layout size changes
    return false;
  }
}