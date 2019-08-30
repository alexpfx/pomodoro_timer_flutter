import 'dart:async';

class SaTimer {
  final Duration totalTime;
  final Stopwatch _stopwatch = new Stopwatch();
  Function onTimerUpdate;
  Function onComplete;
  Duration _currentTime;
  TimerState state = TimerState.ready;

  SaTimer({this.totalTime, this.onTimerUpdate, this.onComplete}){
    _currentTime = totalTime;
  }

  start() {
    if (TimerState.running == state) {
      return;
    }

    _stopwatch.start();
    _currentTime = this.totalTime;
    state = TimerState.running;
    _tick();
  }

  restart() {
    _stopwatch.reset();
    _currentTime = totalTime;
    state = TimerState.ready;
  }

  get currentTime => _currentTime;

  void _tick() {
    if (state == TimerState.ready) {
      return;
    }

    _currentTime = totalTime - _stopwatch.elapsed;
    if (_currentTime.inSeconds > 0) {
      new Timer(Duration(seconds: 1), _tick);
    } else {
      if (onComplete != null) {
        onComplete();
      }
      state = TimerState.ready;
    }

    if (onTimerUpdate != null) {
      onTimerUpdate();
    }
  }
}

enum TimerState { ready, running }
