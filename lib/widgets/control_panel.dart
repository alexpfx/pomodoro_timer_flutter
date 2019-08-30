import 'package:flutter/material.dart';
import 'package:pomodoro_timer/domain/status.dart';



const kTextButtonStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 20);

class ControlPanel extends StatelessWidget {
  final Status status;

  final VoidCallback onCancelPress;
  final VoidCallback onStartPress;

  ControlPanel({this.status, this.onStartPress, this.onCancelPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ButtonTheme(
        buttonColor: Theme.of(context).primaryColor,
        textTheme: ButtonTextTheme.primary,
        minWidth: 220,
        height: 48,
        child: Container(
          child: _buildButtons(context),
        ),
      ),
    );
  }

  _buildButtons(BuildContext context) {
    switch (status) {
      case Status.running:
        return RaisedButton(
          onPressed: onCancelPress,
          child: Text(
            "Cancelar",
            style: kTextButtonStyle,
          ),
        );
      case Status.ready:
      case Status.setup:
        return RaisedButton(
          onPressed: onStartPress,
          child: Text(
            "Start",
            style: kTextButtonStyle,
          ),
        );
    }
  }
}
