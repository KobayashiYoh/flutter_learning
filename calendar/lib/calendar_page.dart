import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TableCalendar(
          focusedDay: DateTime.now(),
          firstDay: DateTime.now(),
          lastDay: DateTime.now(),
        ),
      ),
    );
  }
}
