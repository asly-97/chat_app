import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: accent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: text1,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: accent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your hint in here',
  hintStyle: TextStyle(
    color: text2,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primary1, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: accent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

//Colors
const Color background1 = Color(0xFF20232b);
const Color background2 = Color(0xFF15171c);
const Color background3 = Color(0xFF000000);

const Color primary1 = Color(0xFFb785f6);
const Color primary2 = Color(0xFF5852d6);
const Color accent = Color(0xFFf2fc89);

const Color text1 = Colors.white70;
const Color text2 = Colors.grey;
const Color text3 = Colors.black87;
