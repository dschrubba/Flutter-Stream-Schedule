import 'package:flutter/material.dart';
import 'package:flutter_stream_schedule/widgets/schedule/schedule.dart';

class LandingPage extends StatelessWidget {

  const LandingPage({
    super.key
    });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Schedule()
      );
  }
}
