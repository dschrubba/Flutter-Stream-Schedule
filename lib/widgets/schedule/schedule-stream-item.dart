import 'package:auto_size_text/auto_size_text.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: buildColumn(context, item!)
          )
          )
        )
      ),
    );
     
  }

  List<Widget> buildColumn(BuildContext context, StreamScheduleItem item) {
    List<Widget> children = [];

    // Stream Title
    if (item.streamTitle.isNotEmpty) {
      children.add(
        Text(
          item.streamTitle,
          style: CustomTextTheme().getStyleWithColor(CustomTextTheme().scheduleItemStreamTitle, AppThemeColors.get(Theme.of(context).brightness).onSurface)
        )
      );
    }

    // Game Title
    children.add(
      AutoSizeText(
        item.game.title.isNotEmpty ? item.game.title  : "",
        style: CustomTextTheme().getStyleWithColor(CustomTextTheme().scheduleItemGameTitle, AppThemeColors.get(Theme.of(context).brightness).onSurface)
      )
    );

    // Game Subtitle
    if (item.game.subtitle.isNotEmpty) {
      children.add(
        Text(
          item.game.subtitle,
          style: CustomTextTheme().getStyleWithColor(CustomTextTheme().scheduleItemGameSubTitle, AppThemeColors.get(Theme.of(context).brightness).onSurface)
        )
      );
    }

    return children;
  }
}