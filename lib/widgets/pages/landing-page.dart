import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/services/utils-service.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-week-switcher.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule.dart';
import 'package:rxdart/rxdart.dart';

class LandingPage extends StatelessWidget {
  final BehaviorSubject<int> _calendarWeek = BehaviorSubject<int>();
  final BehaviorSubject<int> _year = BehaviorSubject<int>();
  final BehaviorSubject<CacheWeekItem> _weekItem = BehaviorSubject<CacheWeekItem>();

  LandingPage({
    super.key
    });

  @override
  Widget build(BuildContext context) {

    _year.value = DateTime.now().year;
    _year.listen((int y) {
      log(y.toString());
    });

    _calendarWeek.value = UtilsService.getCurrentCalendarWeek();
    _calendarWeek.listen((int cw) {
      log(cw.toString());
    });

    return SizedBox(
      width: double.infinity,
      child: 
        Stack(
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
                  year: _year,
                  calendarWeekSubject: _calendarWeek,
                ),
                StreamSchedule(
                  year: _year,
                  calendarWeekSubject: _calendarWeek,
                  currentWeek: _weekItem,
                ),
              ],
            ),
          ],
        ),
      );
  }
}
