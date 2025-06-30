import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';
import 'package:intl/intl.dart';

class Utils {

  static DateTime dateTsToDate(dynamic dateTs) {
    dateTs = dateTs.toString();
    final d = int.parse(dateTs.substring(6, 8));
    final m = int.parse(dateTs.substring(4, 6));
    final y = int.parse(dateTs.substring(0, 4));
    return DateTime(y, m, d);
  }

  static int dateToDateTs(DateTime date) {
    return int.parse(
      pad(date.year, l: 4) + 
      pad(date.month) + 
      pad(date.day)
      );
  }

  static int getNumberOfWeeksInYear(int year) {
    // According to ISO 8601, the week with January 4th is always in week 1
    // So we check the ISO week number of December 31st to determine how many weeks the year has
    final dec31 = DateTime(year, 12, 31);
    return isoWeekNumber(dec31);
  }

  static int isoWeekNumber(DateTime date) {
    // ISO week date calculation
    final dayOfYear = int.parse(DateFormat("D").format(date));
    final weekday = (date.weekday + 6) % 7;
    final week = ((dayOfYear - weekday + 10) / 7).floor();
    return week;
  }

  static String getFormattedDate(DateTime d) {
    final DateFormat formatter = DateFormat('dd.MM.yy');
    return formatter.format(d);
  }

  static String pad(dynamic s, {int l = 2, dynamic c = 0}) {
    String str = s.toString();
    while (str.length < l) {
        str = c.toString() + str;
    }
    return str;
  }

  // This uses the ISO 8601 standard (weeks start on Monday, week 1 is the first week with at least 4 days)
  static int getCurrentCalendarWeek() {
    final now = DateTime.now();
    final firstThursday = DateTime(now.year, 1, 4); // always in week 1
    final diff = now.difference(firstThursday);
    return ((diff.inDays + firstThursday.weekday - 1) / 7).floor() + 1;
  }

  // Get Days in Current Week Starting with Monday
  static List<DateTime> getCurrentWeekDates() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  // Get Dates of Calendar Week
  static List<DateTime> daysOfCalendarWeek(int year, int calendarWeek) {
    // ISO 8601: Week 1 has January 4th, and weeks start on Monday
    final jan4 = DateTime(year, 1, 4);
    final jan4Weekday = jan4.weekday; // Monday = 1, Sunday = 7

    // Find the Monday of the first week
    final startOfFirstWeek = jan4.subtract(Duration(days: jan4Weekday - 1));

    // Monday of the target week
    final mondayOfTargetWeek = startOfFirstWeek.add(Duration(days: (calendarWeek - 1) * 7));

    // Return the full week starting from Monday
    return List.generate(7, (i) => mondayOfTargetWeek.add(Duration(days: i)));
  }

  // Get Schedule Items for Calendar Week
  static List<List<StreamScheduleItem>> scheduleItemsForCalendarWeek(List<StreamScheduleItem> scheduleItems, int year, int calendarWeek) {
    // ISO 8601: Week 1 has January 4th, and weeks start on Monday
    List<DateTime> dcw = daysOfCalendarWeek(year, calendarWeek);

    return List.generate(7, (i) =>
      scheduleItems.where((si) => isSameDay(si.date, dcw[i])).toList()
    );
  }

  // Check if two dates share the same day
  static bool isSameDay(DateTime a, DateTime b) {
    return (a.year == b.year) && (a.month == b.month) && (a.day == b.day);
  }

  static String dateTsToDayString(int dateTs) {
    DateTime date = dateTsToDate(dateTs);
    return days[date.weekday-1]!;
  }

  static const Map<int, String> days = {
    0: "Monday",
    1: "Tuesday",
    2: "Wednesday",
    3: "Thursday",
    4: "Friday",
    5: "Saturday",
    6: "Sunday",
  };
}