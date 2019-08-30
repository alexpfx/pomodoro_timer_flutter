class PomodoroSize{
  final String name;
  final int timeInMinutes;

  PomodoroSize(this.name, this.timeInMinutes);

  @override
  String toString() {
    return 'PomodoroSize{name: $name, timeInSeconds: $timeInMinutes}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PomodoroSize &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              timeInMinutes == other.timeInMinutes;

  @override
  int get hashCode =>
      name.hashCode ^
      timeInMinutes.hashCode;




}