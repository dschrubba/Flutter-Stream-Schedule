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
              color: 
                !item!.cancelled
                ? AppThemeColors.get(Theme.of(context).brightness).surface
                : AppThemeColors.get(Theme.of(context).brightness).surfaceDisabled
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

    Color textColor = !item.cancelled
      ? AppThemeColors.get(Theme.of(context).brightness).onSurface
      : AppThemeColors.get(Theme.of(context).brightness).onSurfaceDisabled;

    TextDecoration textDecoration = !item.cancelled
      ? TextDecoration.none
      : TextDecoration.lineThrough;

    // Game Title
    children.add(
      AutoSizeText(
        item.game.title.isNotEmpty ? item.game.title  : "",
        style: CustomTextTheme().scheduleItemGameTitle.copyWith(
          decoration: textDecoration,
          fontSize: hasSubtitle ? 24 : 32, 
          color: textColor
          )
      )
    );

    // Game Subtitle
    if (hasSubtitle) {
      children.add(
        Text(
          item.game.subtitle,
          style: CustomTextTheme().scheduleItemGameSubTitle.copyWith(
            color: textColor,
            decoration: textDecoration
          )
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
              if (!item.cancelled) (
                ScheduleStreamItemBadge(
                  text: "${item.hours}:${item.minutes}",
                  textColor: AppThemeColors.get(Theme.of(context).brightness).onAccent,
                  color: AppThemeColors.get(Theme.of(context).brightness).accent,
                )
              ),
              if (item.cancelled) (
                ScheduleStreamItemBadge(
                  text: "Cancelled",
                  textColor: AppThemeColors.get(Theme.of(context).brightness).onAlert,
                  color: AppThemeColors.get(Theme.of(context).brightness).alert,
                )
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