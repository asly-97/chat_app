import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';

class RoundedButton extends StatelessWidget {
  Color color;
  String title;
  Function onClick;

  RoundedButton(
      {required this.title, required this.color, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onClick();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: text1,
            ),
          ),
        ),
      ),
    );
  }
}
