import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/services/calendar-service.dart';
import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/services/utils-service.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-element.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-week-switcher.dart';

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
      setState(() {
        
      });
    });

    List<Widget> buildElements() {
      List<DateTime> daysOfCalendarWeek = UtilsService.daysOfCalendarWeek(2025, CalendarService.calendarWeek.value);
      List<Widget> list = [];
      for (int key = 0; key < daysOfCalendarWeek.length; key++) {
        DateTime value = daysOfCalendarWeek[key];
        int dateTs = UtilsService.dateToDateTs(value);
        list.insert(key, ScheduleElement(
          scheduleItems: DataService.cache[CalendarService.calendarWeek.value]?.items[dateTs]?.items ?? [],
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
                ScheduleWeekSwitcher(),
                ...buildElements()
              ],
            ),
          ],
        );

  }
}
