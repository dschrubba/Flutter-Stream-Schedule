import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/theme/custom-themes/theme-text.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-stream-item-badge.dart';
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
          height: globals.scheduleItemHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppThemeColors.get(Theme.of(context).brightness).surface
            ),
            child: Container( 
              padding: EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: buildColumn(context, item!)
              )
            )
          )
      )
    );
     
  }

  List<Widget> buildColumn(BuildContext context, StreamScheduleItem item) {
    List<Widget> children = [];
    bool hasSubtitle = item.game.subtitle.isNotEmpty;

    // Game Title
    children.add(
      AutoSizeText(
        item.game.title.isNotEmpty ? item.game.title  : "",
        style: CustomTextTheme().scheduleItemGameTitle.copyWith(
          fontSize: hasSubtitle ? 24 : 32, 
          color: AppThemeColors.get(Theme.of(context).brightness).onSurface
          )
      )
    );

    // Game Subtitle
    if (hasSubtitle) {
      children.add(
        Text(
          item.game.subtitle,
          style: CustomTextTheme().getStyleWithColor(CustomTextTheme().scheduleItemGameSubTitle, AppThemeColors.get(Theme.of(context).brightness).onSurface)
        )
      );
    }

    // Badges
    children.add(
      Padding(
        padding: 
          EdgeInsetsGeometry.only(
            top: 4
          ),
        child:
          Row(
            spacing: 8,
            children: [
              ScheduleStreamItemBadge(
                text: "${item.hours}:${item.minutes}",
                textColor: AppThemeColors.get(Theme.of(context).brightness).onAccent,
                color: AppThemeColors.get(Theme.of(context).brightness).accent,
              ),
              if (item.streamTitle.isNotEmpty) (
                ScheduleStreamItemBadge(
                  text: item.streamTitle,
                  textColor: AppThemeColors.get(Theme.of(context).brightness).surface,
                  color: AppThemeColors.get(Theme.of(context).brightness).onSurface,
                )
              ),
            ],
          )
      )
    );

    return children;
  }
}