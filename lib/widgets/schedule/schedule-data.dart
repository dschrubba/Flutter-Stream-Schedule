class Game {
  final String title;
  final String subtitle;

  Game({required this.title, required this.subtitle});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
  };
}

class StreamScheduleItem {
  final DateTime date;
  final int dateTs;
  final String weekday;
  final String hours;
  final String minutes;
  final String streamTitle;
  final Game game;
  final bool cancelled;

  StreamScheduleItem({
    required this.date,
    required this.dateTs,
    required this.weekday,
    required this.hours,
    required this.minutes,
    required this.streamTitle,
    required this.game,
    required this.cancelled,
  });

  factory StreamScheduleItem.fromJson(Map<String, dynamic> json) {
    return StreamScheduleItem(
      date: DateTime.parse(json['date']),
      dateTs: json['dateTs'].runtimeType == int ? json['dateTs'] : int.parse(json['dateTs']),
      weekday: json['weekday'] ?? '',
      hours: json['hours'] ?? '',
      minutes: json['minutes'] ?? '',
      streamTitle: json['streamTitle'] ?? '',
      game: Game.fromJson(json['game'] ?? {}),
      cancelled: json['cancelled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'weekday': weekday,
    'hours': hours,
    'minutes': minutes,
    'streamTitle': streamTitle,
    'game': game.toJson(),
    'cancelled': cancelled,
  };
}