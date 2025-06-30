import 'package:flutter/foundation.dart';
import 'package:flutter_stream_schedule/static/data-service.dart';
import 'package:flutter_stream_schedule/static/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cacheProvider = ChangeNotifierProvider((ref) {
  return CacheModel(cache: <int, CacheWeekItem>{});
});

class CacheModel extends ChangeNotifier {
  Cache cache;
  CacheModel({required this.cache});

  void updateCache(Cache cache) {
    this.cache = cache;
    notifyListeners();
  }

  void updateCacheItem(int idx, CacheWeekItem cacheWeekItem) {
    cache[idx] = cacheWeekItem;
    notifyListeners();
  }
}

final calendarWeekProvider = ChangeNotifierProvider((ref) {
  return CalendarWeekModel(
    calendarWeek: Utils.getCurrentCalendarWeek(),
    calendarYear: DateTime.now().year,
  );
});

class CalendarWeekModel extends ChangeNotifier {
  int calendarWeek;
  int _calendarYearWeeksCount;
  int _calendarYear;

  set calendarYear(int cw) {
    _calendarYear = cw;
    _calendarYearWeeksCount = Utils.getNumberOfWeeksInYear(cw);
  }

  int get calendarYear => _calendarYear;
  int get calendarYearWeeksCount => _calendarYearWeeksCount;

  CalendarWeekModel({required this.calendarWeek, required int calendarYear})
    : _calendarYear = calendarYear,
      _calendarYearWeeksCount = Utils.getNumberOfWeeksInYear(calendarYear);

  void incrementWeek() {
    calendarWeek++;
    if (calendarWeek > calendarYearWeeksCount) {
      calendarWeek = 0;
      incrementYear();
    } else {
      notifyListeners();
    }
  }

  void decrementWeek() {
    calendarWeek--;
    if (calendarWeek < 1) {
      calendarYear--;
      calendarWeek = Utils.getNumberOfWeeksInYear(calendarYear);
    }
    notifyListeners();
  }

  void setWeek(int cw) {
    calendarWeek = cw;
    notifyListeners();
  }

  void incrementYear() {
    calendarYear++;
    _yearChanged();
    notifyListeners();
  }

  void decrementYear() {
    calendarYear--;
    _yearChanged();
    notifyListeners();
  }

  void setYear(int cw) {
    calendarYear = cw;
    _yearChanged();
    notifyListeners();
  }

  void setYearToCurrent() {
    calendarYear = DateTime.now().year;
    notifyListeners();
  }

  void setBothToCurrent() {
    calendarYear = DateTime.now().year;
    _yearChanged();
    calendarWeek = Utils.getCurrentCalendarWeek();
    notifyListeners();
  }

  void _yearChanged() {
    _calendarYearWeeksCount = Utils.getNumberOfWeeksInYear(calendarYear);
  }

  int getCurrentCacheIndex() {
    return int.parse(calendarYear.toString() + calendarWeek.toString());
  }
}
