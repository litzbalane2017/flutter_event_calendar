import 'package:flutter_event_calendar/src/handlers/EventCalendar.dart';

class EventSelector {
  updateEvents() {
    EventCalendar.selectedEvents = [];

    var i = 0;
    for (var item in EventCalendar.events) {
      var eventDateTimeParts = item.dateTime.split(' ');
      var calendarDateTimeParts = EventCalendar.dateTime.split(' ');
      if (eventDateTimeParts[0] == calendarDateTimeParts[0]) {
        item.listIndex = i;
        EventCalendar.selectedEvents.add(item);
      }

      i++;
    }

    return EventCalendar.selectedEvents;
  }
}
