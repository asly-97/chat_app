import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  bool toRight;
  bool isFirst;
  String content;
  String title;
  Color backgroundColor;
  Color contentColor;
  Color titleColor;

  late BorderRadius _borderRadius;
  final double _radius = 20;
  Bubble({
    this.title = '',
    this.titleColor = text2,
    required this.content,
    this.toRight = true,
    this.isFirst = false,
    this.backgroundColor = primary1,
    this.contentColor = text1,
  }) {
    //Border radius
    if (isFirst) {
      if (toRight) {
        _borderRadius =
            BorderRadius.circular(_radius).copyWith(topRight: Radius.zero);
      } else {
        _borderRadius =
            BorderRadius.circular(_radius).copyWith(topLeft: Radius.zero);
      }
    } else {
      _borderRadius = BorderRadius.circular(_radius);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      child: Column(
        crossAxisAlignment:
            toRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isFirst,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                ),
              ),
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: _borderRadius,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                content,
                style: TextStyle(
                  color: contentColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
