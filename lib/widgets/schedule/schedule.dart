import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/services/utils-service.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-element.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-week-switcher.dart';
import 'package:rxdart/subjects.dart';

enum ScheduleItemState {
  accent,
  cancelled,
  empty,
}

class StreamSchedule extends StatefulWidget { 
  final BehaviorSubject<int> year;
  final BehaviorSubject<int> calendarWeekSubject;
  final BehaviorSubject<CacheWeekItem> currentWeek;

  const StreamSchedule({
    super.key,
    required this.year,
    required this.calendarWeekSubject,
    required this.currentWeek,
  });
  @override
  State<StreamSchedule> createState() => _StreamScheduleState();
}

class _StreamScheduleState extends State<StreamSchedule>  {

  void updateStreams(int year, int calendarWeek) async {

    // Get current DateTime
    DateTime now = DateTime.now();

    // Add threshold to current DateTime
    DateTime threshold = now;
    threshold.minute + 1;

    // Get timestamp of last update of calendar week cache items
    DateTime lastUpdate = DataService.cache[calendarWeek]?.updated ?? DateTime(1999);

    // Check if cache item for week exists and threshold is exceeded,
    // otherwise return
    if (!(DataService.cache.keys.contains(calendarWeek) && lastUpdate.isAfter(now)))
    {
      return null;
    }

    DataService.loadStreams(year, calendarWeek).then((CacheWeekItem? item) => {
    });

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    widget.calendarWeekSubject.listen((int cw) {
      setState(() {
        updateStreams(widget.year.value, widget.calendarWeekSubject.value);
      });
    });

    List<Widget> buildElements() {

      if (!widget.calendarWeekSubject.hasValue) 
      {
        setState(() {
          widget.calendarWeekSubject.value = UtilsService.getCurrentCalendarWeek();
        });
      }

      List<DateTime> daysOfCalendarWeek = UtilsService.daysOfCalendarWeek(2025, widget.calendarWeekSubject.value);
      List<Widget> list = [];
      for (int key = 0; key < daysOfCalendarWeek.length; key++) {
        DateTime value = daysOfCalendarWeek[key];
        int dateTs = UtilsService.dateToDateTs(value);
        list.insert(key, ScheduleElement(
          scheduleItems: DataService.cache[widget.calendarWeekSubject.value]?.items[dateTs]?.items ?? [],
          dateTs: dateTs,
          height: 72,
        ));
      }
      return list;
    }

    return Stack(
          children: [
            Positioned.fill(
              top: -20,
              right: -20,
              bottom: -20,
              left: -20, 
              child:
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    themeColors["bakuretsuCrimson-900"]!, BlendMode.multiply
                  ),
                  child: ImageFiltered(
                    imageFilter: 
                      ImageFilter.blur(
                        sigmaX: 48.0,
                        sigmaY: 48.0,
                        tileMode: TileMode.mirror,
                      ),
                      child: 
                        Image.asset(
                          "assets/images/bg.png",
                          fit: 
                            BoxFit.cover,
                          ),
                  ),
                )
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ScheduleWeekSwitcher(
                  year: widget.year,
                  calendarWeekSubject: widget.calendarWeekSubject,
                ),
                ...buildElements()
              ],
            ),
          ],
        );

  }
}
