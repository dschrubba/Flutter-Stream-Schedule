import 'package:flutter_stream_schedule/services/utils-service.dart';
import 'package:rxdart/subjects.dart';

class CalendarService {
  static final BehaviorSubject<int> calendarWeek = BehaviorSubject.seeded(UtilsService.getCurrentCalendarWeek());
  static final BehaviorSubject<int> year = BehaviorSubject.seeded(DateTime.now().year);
}
