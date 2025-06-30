import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stream_schedule/providers.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule-data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

class DataService {
  
  static Future<CacheWeekItem?> updateStreams(int year, int calendarWeek, WidgetRef ref) async {
    log("updateStreams called");

    final cache = ref.read(cacheProvider).cache;
    final now = DateTime.now();
    final threshold = now.subtract(const Duration(minutes: 1));
    final lastUpdate = cache[calendarWeek]?.updated ?? DateTime(1999);

    // Only update if cache exists and data is newer than threshold
    if (!(!cache.containsKey(calendarWeek) || lastUpdate.isBefore(threshold))) {
      return null;
    }

    return await DataService.loadStreams(year, calendarWeek, ref);
  }

  static Future<CacheWeekItem?> loadStreams(int year, int cw, WidgetRef ref) async {
    log("loadStreams called");
    final Response res = await get(Uri.parse('${dotenv.env['API_STREAMS_LIST']}/$year/$cw'));

    // String key is dateTs
    final Map<String, dynamic> decoded = json.decode(res.body) as Map<String, dynamic>;

    CacheWeekItem? cacheWeekItem;
    if (res.statusCode.toString().startsWith("2")) {
      cacheWeekItem = CacheWeekItem(
        requestStatus: res.statusCode,
        calendarWeek: cw,
        updated: DateTime.now(),
        items: decoded.map((key, value) => MapEntry(
          int.parse(key),
          CacheDayItem(
            dateTs: int.parse(key),
            items: (value as List)
                .map<StreamScheduleItem>((item) => StreamScheduleItem.fromJson(item))
                .toList(),
          ),
        )),
      );
      ref.read(cacheProvider).updateCacheItem(ref.read(calendarWeekProvider).getCurrentCacheIndex(), cacheWeekItem);
    } 
    else if(decoded["statusCode"].toString().startsWith("4")) {
      log("API returned 4XX");
    }
    return cacheWeekItem;
  } 
}

// String Index = Year + Calendar Week (e.g. 202507)
typedef Cache = Map<int, CacheWeekItem>;

class CacheWeekItem {
  int requestStatus;
  int calendarWeek;
  Map<int, CacheDayItem> items = {};
  DateTime updated;

  CacheWeekItem({
    required this.requestStatus,
    required this.calendarWeek, 
    required this.items, 
    required this.updated
  });

  factory CacheWeekItem.fromJson(Map<String, dynamic> json) {
    return CacheWeekItem(
      requestStatus: json['requestStatus'], 
      calendarWeek: json['calendarWeek'], 
      items: json['items'], 
      updated: json['updated']
    );
  }
}

class CacheDayItem {
  int dateTs;
  List<StreamScheduleItem> items;

  CacheDayItem({
    required this.dateTs, 
    required this.items
  });

  factory CacheDayItem.fromJson(Map<String, dynamic> json) {
    return CacheDayItem(
      dateTs: json['dateTs'], 
      items: json['items']
    );
  }
}