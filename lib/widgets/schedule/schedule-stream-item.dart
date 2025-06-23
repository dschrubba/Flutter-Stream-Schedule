import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';
import '/globals.dart' as globals;

class ScheduleStreamItem extends StatelessWidget {

  final StreamScheduleItem? item;

  const ScheduleStreamItem({
    super.key, 
    required this.item
  });

  @override
  Widget build(BuildContext context) {

    if (item == null || item?.game == null) {
      return Container();
    }

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.all(Radius.circular(globals.borderRadius)),
      child: SizedBox(
        height: globals.dayBadgeHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppThemeColors.get(Theme.of(context).brightness).surface
          ),
          child: Container( 
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: buildColumn(context, item!)
          )
          )
        )
      ),
    );
     
  }

  List<Widget> buildColumn(BuildContext context, StreamScheduleItem item) {
    List<Widget> children = [];

    if (item.streamTitle.isNotEmpty) {
      children.add(
        Text(
          item.streamTitle,
          style: CustomTextTheme().getStyleWithColor(CustomTextTheme().labelSmall, AppThemeColors.get(Theme.of(context).brightness).onSurface)
        )
      );
    }
    children.add(
      Text(
        item.game.title.isNotEmpty ? item.game.title  : "",
        style: CustomTextTheme().getStyleWithColor(CustomTextTheme().labelLarge, AppThemeColors.get(Theme.of(context).brightness).onSurface)
      )
    );

    return children;
  }
}