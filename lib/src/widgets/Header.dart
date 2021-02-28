import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';

class Header extends StatelessWidget {
  int _currentMonth = int.parse(DateTime.now().month.toString());
  int _lowerLimit = int.parse(DateTime.now().subtract(Duration(days: 2)).day.toString());
  int _higherLimit = int.parse(DateTime.now().add(Duration(days: 6)).day.toString());
  int _selectedDay = int.parse(EventCalendar.dateTime.split(" ")[0].toString().substring(8));
  int _selectedMonth = int.parse(EventCalendar.dateTime.split(" ")[0].toString().substring(5, 7));

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
          children: [
            _lowerLimit < _selectedDay || _selectedMonth > _currentMonth
                ? InkWell(
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
            )
                : Container(),
            Row(
              textDirection: EventCalendar.isRTL ? TextDirection.rtl : TextDirection.ltr,
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
            _higherLimit > _selectedDay
                ? InkWell(
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
            )
                : _selectedMonth <= _currentMonth
                ? InkWell(
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
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
