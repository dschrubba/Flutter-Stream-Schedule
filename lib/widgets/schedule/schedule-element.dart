import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-day-badge.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-stream-item.dart';
import 'package:flutter_stream_schedule/static/utils.dart';
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

    var validItems = scheduleItems.nonNulls.toList();

    // Get earliest dateTs
    int? minDateTs = validItems.isNotEmpty
         ? validItems.map((e) => e.dateTs).reduce((a, b) => a < b ? a : b)
         : null;

    // Get first item with earliest dateTs
    StreamScheduleItem? firstItem = validItems.where((element) => element.dateTs == minDateTs).toList().firstOrNull;

    ScheduleItemState state = ScheduleItemState.accent;
    if (firstItem?.cancelled ?? false) {
      state = ScheduleItemState.cancelled;
    }
    else if (validItems.isEmpty) {
      state = ScheduleItemState.empty;
    }

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            child: 
              Container(
                padding: 
                  EdgeInsets.only(
                    left: globals.dayBadgeWidth + (globals.dayBadgeAdjustmentPadding / 2),
                    right: (globals.dayBadgeAdjustmentPadding / 2)
                  ),
                child: 
                  Row(
                    spacing: 16,
                    children: [
                      _buildRow(validItems)
                    ]
                  ),
              )
          ),
          // Day Badge
          ScheduleDayBadge(
            state: state,
            dateTs: dateTs,
            day: Utils.dateTsToDayString(context, dateTs),
          ),
        ]
      )
    );
  }

  Widget _buildRow(List<StreamScheduleItem> items) {
      List<Widget> list = [];
      for (var item in items) {
        list.add(
          ScheduleStreamItem(item: item)
        );
      }
      return Row(children: list);
  }

}