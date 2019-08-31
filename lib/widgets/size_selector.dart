import 'package:flutter/material.dart';
import 'package:pomodoro_timer/domain/pomodoro_size.dart';
import 'package:pomodoro_timer/domain/status.dart';

const kTextStyleNormal = TextStyle(fontWeight: FontWeight.w500);

final kTextStyleSelected =
    kTextStyleNormal.copyWith(fontWeight: FontWeight.w600, color: Colors.white);

class SizeSelector extends StatelessWidget {
  final List<PomodoroSize> sizes;
  Function onSizeSelected;
  PomodoroSize selected;
  Status status;

  SizeSelector({this.sizes, this.onSizeSelected, this.selected, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtons(),
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return sizes.map<Widget>((s) => _buildButton(selected, s)).toList();
  }

  _buildButton(PomodoroSize selected, PomodoroSize selector) {
    var isRunning = Status.running == status;

    var isSelected = selected == selector;

    return ButtonTheme(
        height: 52,
        minWidth: 60,
        child: isSelected
            ? RaisedButton(
                onPressed: isRunning ? null : () {},
                child: Text(
                  selector.name,
                  style: kTextStyleSelected,
                ),
              )
            : FlatButton(
                onPressed: isRunning ? null : () => onSizeSelected(selector),
                child: Text(
                  selector.name,
                  style: kTextStyleNormal,
                ),
              ));
  }
}
