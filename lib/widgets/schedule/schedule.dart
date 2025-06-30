import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/services/calendar-service.dart';
import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/static/utils.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-element.dart';

enum ScheduleItemState {
  accent,
  cancelled,
  empty,
}

class Schedule extends StatefulWidget { 
  const Schedule({
    super.key,
  });
  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule>  {
  @override
  Widget build(BuildContext context) {
    CalendarService.calendarWeek.listen((int cw) {
      setState(() {});
    });
    List<Widget> listItems = _generateListItems();

    return Column(
      children: [...listItems],
    );
  }

  List<Container> _generateListItems() {
    List<DateTime> daysOfCalendarWeek = Utils.daysOfCalendarWeek(2025, CalendarService.calendarWeek.value);
    List<Container> list = [];
    // Iterate over days of calendar week, generate Schedule Elements
    for (int key = 0; key < daysOfCalendarWeek.length; key++) {
      DateTime value = daysOfCalendarWeek[key];
      int dateTs = Utils.dateToDateTs(value);
      // Add Schedule Elements to list
      list.insert(key, Container(
        margin: EdgeInsets.only(top: 16),
        child: ScheduleElement(
        scheduleItems: DataService.cache[CalendarService.calendarWeek.value]?.items[dateTs]?.items ?? [],
        dateTs: dateTs,
        height: 72,
        ))
      );
    }
    return list;
  }
}
