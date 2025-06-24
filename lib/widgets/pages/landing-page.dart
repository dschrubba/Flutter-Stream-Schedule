import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/services/utils-service.dart';
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
      child: StreamSchedule(year: _year, calendarWeekSubject: _calendarWeek, currentWeek: _weekItem)
      );
  }
}
