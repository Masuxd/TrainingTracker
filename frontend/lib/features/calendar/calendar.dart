import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // flutter calendar package

void main() {
  runApp(MaterialApp(home: MyApp())); // korjaa materiallocalization errorin
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class Event {
  final String title;
  Event(this.title);
}

class _MyAppState extends State<MyApp> {
  DateTime today = DateTime.now(); //päivämäärä
  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day; // päivämäärä johon on klikattu
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(title: const Text("Training Calendar")), // Otsikko
        floatingActionButton: FloatingActionButton(
          //nappi jolla voi lisätä tapahtuman
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text("Event name"),
                    content: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        controller: _eventController,
                      ),
                    ),
                  );
                });
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, today),
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2040, 12, 31),
              focusedDay: today,
              onDaySelected: _onDaySelected,
            ),
          ],
        ),
      ),
    );
  }
}
