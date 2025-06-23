import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-day-badge.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-stream-item.dart';
import 'package:flutter_stream_schedule/services/utils-service.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule.dart';
import '/globals.dart' as globals;

class ScheduleElement extends StatelessWidget {
  const ScheduleElement({
    super.key, required this.dateTs, required this.height, required this.scheduleItems
  });

  final int dateTs;
  final double height;
  final List<StreamScheduleItem> scheduleItems;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = CustomTextTheme().getStyleWithColor(CustomTextTheme().monoLabelSmall, AppThemeColors.get(Theme.of(context).brightness).accent);

    StreamScheduleItem? item;
    var validItems = scheduleItems.nonNulls.toList();
    if (validItems.isNotEmpty) {
      item = StreamScheduleItem(
        date: validItems[0].date, 
        dateTs: validItems[0].dateTs, 
        weekday: validItems[0].weekday, 
        hours: validItems[0].hours, 
        minutes: validItems[0].minutes, 
        streamTitle: validItems[0].streamTitle, 
        game: validItems[0].game, 
        cancelled: validItems[0].cancelled);
    }

    ScheduleItemState state = ScheduleItemState.accent;
    if (item != null && item.cancelled) {
      state = ScheduleItemState.cancelled;
    }
    else if (validItems.isEmpty) {
      state = ScheduleItemState.empty;
    }

    return ConstrainedBox(
      constraints: 
        BoxConstraints(
          // Schedule Element Constraints
          // This is NOT the Day Badge
          // Schedule Element = Whole Row!
          maxHeight: globals.dayBadgeHeight,
          maxWidth: double.infinity,
        ),
      child: 
        Container(
          width: double.infinity,
          padding: 
            EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 8
            ),
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: 
                  Container(
                    padding: 
                      EdgeInsets.only(
                        left: globals.dayBadgeWidth + globals.dayBadgeAdjustmentPadding
                      ),
                    child: 
                      Row(
                        children: [
                          ScheduleStreamItem(item: item)
                        ]
                      ),
                  )
              ),
              // Day Badge
              ScheduleDayBadge(
                state: state,
                dateTs: dateTs,
                day: UtilsService.dateTsToDayString(dateTs), 
                height: height
              ),
            ]
          )
        )
      );
  }
}