import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/services/utils-service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';

class ScheduleWeekSwitcher extends StatefulWidget {

  final BehaviorSubject<int> calendarWeekSubject;
  final BehaviorSubject<int> year;

  const ScheduleWeekSwitcher({
    required this.calendarWeekSubject,
    required this.year,
    super.key
    });

  @override
  State<ScheduleWeekSwitcher> createState() => _ScheduleWeekSwitcherState();
}

class _ScheduleWeekSwitcherState extends State<ScheduleWeekSwitcher> {

  void changeCalendarWeekBy(int n) {
    setState(() {
      widget.calendarWeekSubject.value += n;
      if (widget.calendarWeekSubject.value > UtilsService.getNumberOfWeeksInYear(widget.year.value)) {
        widget.year.value++;
        widget.calendarWeekSubject.value = 1;
      }
      else if (widget.calendarWeekSubject.value < 1) {
        widget.year.value--;
        widget.calendarWeekSubject.value = UtilsService.getNumberOfWeeksInYear(widget.year.value);
      }
      DataService.loadStreams(widget.year.value, widget.calendarWeekSubject.value);
    });
  }

  String buildDateRangeString(int cw) {
    List<DateTime> days = UtilsService.daysOfCalendarWeek(widget.year.value, cw);
    String firstDay = UtilsService.getFormattedDate(days[0]);
    String lastDay  = UtilsService.getFormattedDate(days[days.length - 1]);
    return "$firstDay  bis  $lastDay"; 
  }

  @override
  Widget build(BuildContext context) {
    DataService.loadStreams(widget.year.value, widget.calendarWeekSubject.value);
    ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: WidgetStateColor.resolveWith((c) => AppThemeColors.get(Theme.of(context).brightness).accent),
      textStyle: WidgetStateTextStyle.resolveWith((t) => TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      )
    );

    return Padding(
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
                onPressed: () => {},
                style: buttonStyle,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(vertical: 0, horizontal: 4),
                  child: Text(
                    buildDateRangeString(widget.calendarWeekSubject.value), 
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
    );
  }
}