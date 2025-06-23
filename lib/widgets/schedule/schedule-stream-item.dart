import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';

class ScheduleStreamItem extends StatelessWidget {

  final StreamScheduleItem? item;

  const ScheduleStreamItem({
    super.key, 
    required this.item
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        item?.game.title ?? ""
      ),
    );
  }
}