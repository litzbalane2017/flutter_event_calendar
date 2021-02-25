import 'package:flutter/material.dart';

class Event {
  int listIndex;
  String title;
  String description;
  String dateTime;
  Function onTap;
  Function onLongPress;
  Widget flag;

  Event({
    title,
    description,
    dateTime,
    onTap(int listIndex),
    onLongPress,
    flag
  }) {
    this.title = title ?? '';
    this.description = description ?? '';
    this.dateTime = dateTime ?? '';
    this.onTap = onTap ??
        (int listIndex) {
          print('Tap ' + listIndex.toString());
        };
    this.onLongPress = onLongPress ??
        (int listIndex) {
          print('LongPress ' + listIndex.toString());
        };
    this.flag = flag ?? '';
  }
}
