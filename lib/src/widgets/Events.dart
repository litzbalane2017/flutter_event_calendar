import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/src/handlers/CalendarSelector.dart';
import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';
import 'package:flutter_event_calendar/src/handlers/EventSelector.dart';
import 'package:flutter_event_calendar/src/handlers/Translator.dart';
import 'package:flutter_event_calendar/src/widgets/EventCard.dart';

class Events extends StatelessWidget {
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
              // left
              switch (EventCalendar.isRTL) {
                case true:
                  CalendarSelector().nextDay();
                  break;
                case false:
                  CalendarSelector().previousDay();
                  break;
              }
              onEventsChanged.call();
            } else {
              // right
              switch (EventCalendar.isRTL) {
                case true:
                  CalendarSelector().previousDay();
                  break;
                case false:
                  CalendarSelector().nextDay();
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
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: EventCalendar.emptyTextColor,
              fontFamily: EventCalendar.font,
            ),
          ),
        ],
      ));

    return eventCards;
  }
}
