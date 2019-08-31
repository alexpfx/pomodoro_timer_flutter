import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/domain/pomodoro_size.dart';
import 'package:pomodoro_timer/domain/satimer.dart';
import 'package:pomodoro_timer/domain/status.dart';
import 'package:pomodoro_timer/widgets/control_panel.dart';
import 'package:pomodoro_timer/widgets/pomodoro_timer.dart';
import 'package:pomodoro_timer/widgets/size_selector.dart';

void main() => runApp(MyApp());

/* Orientado a objetivos. Descontar se objetivo não for concluido. */
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Pomodoro"),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SaTimer timer;

  AudioCache player = AudioCache();
  PomodoroSize _pomodoroSizeSelected;
  List<PomodoroSize> _pomodoroSizes;

  @override
  void initState() {
    player = AudioCache();
    player.loadAll(['bugle_tune.mp3', 'beep_short.mp3']);

    _pomodoroSizes = _getSizes().reversed.toList();
    _pomodoroSizeSelected = _pomodoroSizes[(_pomodoroSizes.length / 2).floor()];

    initTimer(_pomodoroSizeSelected);
  }

  _getStatus() {
    if (timer == null) {
      return Status.setup;
    } else if (timer.state == TimerState.running) {
      return Status.running;
    } else if (timer.state == TimerState.ready) {
      return Status.ready;
    }
  }

  _onTimerUpdate() {
    setState(() {});
  }

  _onTimerCompleted() {
    player.play('bugle_tune.mp3');
  }

  _onStartPress() {
    timer.start();
    player.play("beep_short.mp3");
  }

  _onCancelPress() {
    timer.restart();
    _onTimerUpdate();
  }

  _onSelected(PomodoroSize s) {
    initTimer(s);
    _pomodoroSizeSelected = s;
    setState(() {});
  }

  void initTimer(PomodoroSize s) {
    timer = SaTimer(
        totalTime: Duration(minutes: s.timeInMinutes),
        onTimerUpdate: _onTimerUpdate,
        onComplete: _onTimerCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new SizeSelector(
              sizes: _pomodoroSizes,
              selected: _pomodoroSizeSelected,
              onSizeSelected: _onSelected,
              status: this._getStatus(),
            ),
          ),
          Expanded(
              child: new PomodoroTimer(
                  timer?.currentTime ?? Duration(minutes: 25),
                  timer?.totalTime ?? Duration(minutes: 25))),
          new ControlPanel(
            status: _getStatus(),
            onStartPress: _onStartPress,
            onCancelPress: _onCancelPress,
          ),
        ],
      ),
    );
  }

  List<PomodoroSize> _getSizes() {
    return [
      PomodoroSize("GG", 60),
      PomodoroSize("G", 48),
      PomodoroSize("M", 36),
      PomodoroSize("P", 24),
      PomodoroSize("PP", 18),
    ];
  }
}
