import 'package:flutter/material.dart';
import 'package:pomodoro_timer/domain/pomodoro_size.dart';
import 'package:pomodoro_timer/domain/status.dart';

const kTextStyleNormal = TextStyle(fontWeight: FontWeight.w400);

final kTextStyleSelected =
    kTextStyleNormal.copyWith(fontWeight: FontWeight.w600);

class SizeSelector extends StatelessWidget {
  final List<PomodoroSize> sizes;
  Function onSizeSelected;
  PomodoroSize selected;
  Status status;

  SizeSelector({this.sizes, this.onSizeSelected, this.selected, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildButtons(),
      ),
    );
  }

  List<Widget> _buildButtons() {
    return sizes.map<Widget>((s) => _buildButton(selected, s)).toList();
  }

  _buildButton(PomodoroSize selected, PomodoroSize selector) {
    return ButtonTheme(
        height: 48,
        minWidth: 48,
        child: OutlineButton(
          borderSide: selected == selector
              ? BorderSide(
                  color: Colors.blue, width: 2, style: BorderStyle.solid)
              : null,
          onPressed:
              Status.running != status ? () => onSizeSelected(selector) : null,
          child: Text(
            selector.name,
            style: kTextStyleNormal,
          ),
        ));
  }
}
