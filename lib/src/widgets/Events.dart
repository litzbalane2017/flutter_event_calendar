import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/EventSelector.dart';
import 'package:flutter_event_calendar/src/handlers/Translator.dart';
import 'package:flutter_event_calendar/src/widgets/EventCard.dart';

class Events extends StatelessWidget {
  int _currentMonth = int.parse(DateTime.now().month.toString());
  int _lowerLimit = int.parse(DateTime.now().subtract(Duration(days: 4)).day.toString());
  int _higherLimit = int.parse(DateTime.now().add(Duration(days: 6)).day.toString());
  int _selectedDay = int.parse(EventCalendar.dateTime.split(" ")[0].toString().substring(8));
  int _selectedMonth = int.parse(EventCalendar.dateTime.split(" ")[0].toString().substring(5, 7));

  Function onEventsChanged;

  Events({this.onEventsChanged});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: GestureDetector(
          onPanEnd: ((details) {
            Velocity vc = details.velocity;
            String clearVc;
            clearVc = vc.toString().replaceAll('(', '');
            clearVc = clearVc.toString().replaceAll(')', '');
            clearVc = clearVc.toString().replaceAll('Velocity', '');
            if (double.parse(clearVc.toString().split(',')[0]) > 0) {
              switch (EventCalendar.isRTL) {
                case true:
                  CalendarSelector().nextDay();
                  break;
                case false:
                  if (_lowerLimit < _selectedDay || _selectedMonth > _currentMonth) CalendarSelector().previousDay();
                  break;
              }
              onEventsChanged.call();
            } else {
              switch (EventCalendar.isRTL) {
                case true:
                  CalendarSelector().previousDay();
                  break;
                case false:
                  if (_higherLimit > _selectedDay) {
                    CalendarSelector().nextDay();
                  } else if (_selectedMonth <= _currentMonth) {
                    CalendarSelector().nextDay();
                  }
                  break;
              }
              onEventsChanged.call();
            }
          }),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: eventCardsMaker(),
          ),
        ),
      ),
    );
  }

  List<Widget> eventCardsMaker() {
    var selectedEvents = EventSelector().updateEvents();
    List<Widget> eventCards = [];
    for (var item in selectedEvents)
      eventCards.add(
        EventCard(
          fullCalendarEvent: item,
        ),
      );

    if (selectedEvents.length == 0)
      eventCards.add(Column(
        children: [
          Icon(
            EventCalendar.emptyIcon,
            size: 45,
            color: EventCalendar.emptyIconColor,
          ),
          Text(
            '${EventCalendar.emptyText != null ? EventCalendar.emptyText : Translator().trans('empty')}',
            style: TextStyle(
              color: EventCalendar.emptyTextColor,
              fontSize: 20,
              fontFamily: EventCalendar.font,
            ),
          ),
        ],
      ));

    return eventCards;
  }
}
