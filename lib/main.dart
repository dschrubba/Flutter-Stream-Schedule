import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stream_schedule/services/calendar-service.dart';
import 'package:flutter_stream_schedule/services/data-service.dart';
import 'package:flutter_stream_schedule/theme/theme-colors.dart';
import 'package:flutter_stream_schedule/theme/theme.dart';
import 'package:flutter_stream_schedule/widgets/app-logo.dart';
import 'package:flutter_stream_schedule/widgets/pages/landing-page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;
  debugPaintLayerBordersEnabled = false;
  debugPaintSizeEnabled = false;

  await dotenv.load(fileName: ".env"); //path to your .env file
  runApp(
    ProviderScope(
      child: const MyApp()
      )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    log("MyApp:build called");
    DataService.updateStreams(
      CalendarService.year.value,
      CalendarService.calendarWeek.value,
    );
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MyHomePage(title: 'App Name'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColors['nocturnal-900'],
        title: Row(
          children: [
            AppLogo(
              name: 'AppBarLogo',
              location: 'assets/icons/logo.svg',
              height: 48,
              color: AppThemeColors.get(Theme.of(context).brightness).accent,
            ),
          ],
        ),
      ),
      body: SafeArea(child: LandingPage()),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: _incrementCounter,
      //  tooltip: 'Increment',
      //  child: const Icon(Icons.add),
      //),
    );
  }
}
