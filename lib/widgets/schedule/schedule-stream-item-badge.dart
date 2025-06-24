import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';

class ScheduleStreamItemBadge extends StatelessWidget {

  final String text;
  final Color textColor;
  final Color color;
  
  const ScheduleStreamItemBadge({
    super.key, 
    required this.text,
    required this.textColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = CustomTextTheme().getStyleWithColor(
      CustomTextTheme().scheduleItemBadge, 
      textColor
      );
  
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(90),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: color
        ),
        child: Container( 
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            child: Text(
              text,
              style: textStyle,
            ),
          )
      )
    );
  }
}