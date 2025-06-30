import 'package:flutter_stream_schedule/static/utils.dart';
import 'package:rxdart/subjects.dart';

class CalendarService {
  static final BehaviorSubject<int> calendarWeek = BehaviorSubject.seeded(Utils.getCurrentCalendarWeek());
  static final BehaviorSubject<int> year = BehaviorSubject.seeded(DateTime.now().year);
}
