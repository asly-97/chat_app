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

  Bubble({
    this.title = '',
    this.titleColor = text2,
    required this.content,
    this.toRight = true,
    this.isFirst = false,
    this.backgroundColor = primary1,
    this.contentColor = text1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: Column(
        crossAxisAlignment:
            toRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: toRight
                ? BorderRadius.circular(20).copyWith(topRight: Radius.zero)
                : BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
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
