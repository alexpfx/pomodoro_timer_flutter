import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PomodoroTimer extends StatelessWidget {
  DateFormat countdownTimeFormat = new DateFormat('mm:ss');
  final Duration currentTime;
  final Duration totalTime;

  PomodoroTimer(this.currentTime, this.totalTime) {
    if (totalTime.inMinutes > 59) {
      countdownTimeFormat = new DateFormat('HH:mm:ss');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LinearProgressIndicator(
            value: currentTime.inSeconds / totalTime.inSeconds,
          ),
          Text(
            getFormatedTime(),
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
          ),
          SizedBox.shrink()
        ],
      ),
    );
  }

  String getFormatedTime() {
    DateTime dateTime = new DateTime(
        new DateTime.now().year, 0, 0, 0, 0, currentTime.inSeconds);
    return countdownTimeFormat.format(dateTime);
  }
}
