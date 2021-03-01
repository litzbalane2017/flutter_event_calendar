import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';

class Header extends StatelessWidget {
  Function onHeaderChanged;

  Header({this.onHeaderChanged});

  @override
  Widget build(BuildContext context) {
    int selectedDay = int.parse(EventCalendar.dateTime.split(" ")[0].toString().substring(8));
    int selectedMonth = int.parse(EventCalendar.dateTime.split(" ")[0].toString().substring(5, 7));
    int monthLength = DateTime(DateTime.now().year, DateTime.now().month + 1, 0).day;
    if (higherLimit <= 6) higherLimit = monthLength;

    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            lowerLimit < selectedDay || selectedMonth > currentMonth || (currentDay < 4 && selectedMonth == currentMonth) || (currentDay == 4 && selectedMonth == currentMonth) ?
              InkWell(
                  onTap: () {
                    indexer--;
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
                ) : InkWell(
              onTap: null,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: const Color(0xFF15222D),
                  size: 18,
                ),
              ),
            ),
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
            higherLimit > selectedDay
                ? InkWell(
              onTap: () {
                indexer++;
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
            ) : selectedMonth < currentMonth
                ? InkWell(
              onTap: () {
                indexer++;
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
            ) :  InkWell(
              onTap: null,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF15222D),
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
