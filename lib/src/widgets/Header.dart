import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/widgets/SelectMonth.dart';
import 'package:flutter_event_calendar/src/widgets/SelectYear.dart';

class Header extends StatelessWidget {
  Function onHeaderChanged;

  Header({this.onHeaderChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Title , next and previous button
          children: [
            InkWell(
              onTap: () {
                CalendarSelector().previousDay();
                onHeaderChanged.call();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            Row(
              textDirection:
                  EventCalendar.isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Container(
                  child: Text(
                    '${CalendarSelector().getPart(format: 'month', responseType: 'string')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      fontFamily: EventCalendar.font,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                CalendarSelector().nextDay();
                onHeaderChanged.call();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
