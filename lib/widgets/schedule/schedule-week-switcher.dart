import 'package:flutter_stream_schedule/services/calendar-service.dart';
import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/services/utils-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';

class ScheduleWeekSwitcher extends StatefulWidget {

  const ScheduleWeekSwitcher({
    super.key
    });

  @override
  State<ScheduleWeekSwitcher> createState() => _ScheduleWeekSwitcherState();
}

class _ScheduleWeekSwitcherState extends State<ScheduleWeekSwitcher> {

  void changeCalendarWeekBy(int n) {
    setState(() {
      CalendarService.calendarWeek.value += n;
      if (CalendarService.calendarWeek.value > UtilsService.getNumberOfWeeksInYear(CalendarService.year.value)) {
        CalendarService.year.value++;
        CalendarService.calendarWeek.value = 1;
      }
      else if (CalendarService.calendarWeek.value < 1) {
        CalendarService.year.value--;
        CalendarService.calendarWeek.value = UtilsService.getNumberOfWeeksInYear(CalendarService.year.value);
      }
      DataService.updateStreams(CalendarService.year.value, CalendarService.calendarWeek.value);
    });
  }

  void jumpToCurrentWeek() {
    setState(() {
      CalendarService.year.value = DateTime.now().year;
      CalendarService.calendarWeek.value = UtilsService.getCurrentCalendarWeek();
      DataService.updateStreams(CalendarService.year.value, CalendarService.calendarWeek.value);
    });
  }

  String buildDateRangeString(int cw) {
    List<DateTime> days = UtilsService.daysOfCalendarWeek(CalendarService.year.value, cw);
    String firstDay = UtilsService.getFormattedDate(days[0]);
    String lastDay  = UtilsService.getFormattedDate(days[days.length - 1]);
    return "$firstDay  bis  $lastDay"; 
  }

  @override
  Widget build(BuildContext context) {

    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateColor.resolveWith((c) => AppThemeColors.get(Theme.of(context).brightness).accent),
      textStyle: WidgetStateTextStyle.resolveWith((t) => TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      )
    );

    return Container(
      decoration: BoxDecoration(
        color: AppThemeColors.get(Theme.brightnessOf(context)).accent.withAlpha(64),
        backgroundBlendMode: 
          Theme.brightnessOf(context) == Brightness.light
          ? BlendMode.screen
          : BlendMode.multiply
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton.filled(
                onPressed: () => {
                  changeCalendarWeekBy(-1)
                },
                style: buttonStyle,
                icon: 
                  Icon(
                    Icons.chevron_left,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  color: AppThemeColors.get(Theme.of(context).brightness).onAccent,
              ),
              FilledButton(
                onPressed: () => {
                  jumpToCurrentWeek()
                },
                style: buttonStyle,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 0, horizontal: 4),
                  child: Text(
                    buildDateRangeString(CalendarService.calendarWeek.value), 
                    style: CustomTextTheme().getStyle(CustomFontFamilies.generalSans).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppThemeColors.get(Theme.of(context).brightness).onAccent
                      ),
                    )
              )),
              IconButton.filled(
                onPressed: () => {
                  changeCalendarWeekBy(1)
                  },
                style: buttonStyle,
                icon: 
                  Icon(
                    Icons.chevron_right,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  color: AppThemeColors.get(Theme.of(context).brightness).onAccent,
              )
            ]
          )
        )
      )
    );
  }
}