import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';

class ScheduleStreamItem extends StatelessWidget {

  final StreamScheduleItem? item;

  const ScheduleStreamItem({
    super.key, 
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ColoredBox(
        color: Colors.green,
        child: Text(
          item?.game.title ?? "",
          style: CustomTextTheme().bodyLarge,
        ),
      ),
    );
  }
}