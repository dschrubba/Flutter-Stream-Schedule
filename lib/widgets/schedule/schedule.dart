import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/providers.dart';
import 'package:flutter_stream_schedule/static/data-service.dart';
import 'package:flutter_stream_schedule/static/utils.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-element.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ScheduleItemState {
  accent,
  cancelled,
  empty,
}

class Schedule extends HookConsumerWidget {
    
  const Schedule({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("Schedule:build called");

    ref.listen<CalendarWeekModel>(calendarWeekProvider, (previous, next) {
      DataService.updateStreams(
        next.calendarYear, 
        next.calendarWeek,
        ref
        ).then((c) {
          if (c != null) {
            ref.read(cacheProvider).cache[ref.read(calendarWeekProvider).getCurrentCacheIndex()] = c;
          }
        });
    });

    var currentCacheIndex = ref.watch(calendarWeekProvider).getCurrentCacheIndex();
    var year = ref.read(calendarWeekProvider).calendarYear;
    var week = ref.read(calendarWeekProvider).calendarWeek;

    List<Widget> listItems = _generateListItems(ref, year, week, currentCacheIndex);
    return Column(
      children: [...listItems],
    );
  }

  List<Container> _generateListItems(WidgetRef ref, int year, int week, int currentCacheIndex) {
    List<DateTime> daysOfCalendarWeek = Utils.datesOfCalendarWeek(year, week);
    List<Container> list = [];
    // Iterate over days of calendar week, generate Schedule Elements
    for (int key = 0; key < daysOfCalendarWeek.length; key++) {
      DateTime value = daysOfCalendarWeek[key];
      int dateTs = Utils.dateToDateTs(value);
      // Add Schedule Elements to list
      list.insert(key, Container(
        margin: EdgeInsets.only(top: 16),
        child: ScheduleElement(
        scheduleItems: ref.watch(cacheProvider).cache[currentCacheIndex]?.items[dateTs]?.items ?? [],
        dateTs: dateTs,
        height: 72,
        ))
      );
    }
    return list;
  }
}
