import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // flutter calendar package

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class Event {
  final String name;
  Event(this.name);

  @override
  String toString() => name;
}

class _MyAppState extends State<MyApp> {
  DateTime today = DateTime.now();
  final TextEditingController _eventController = TextEditingController();
  final Map<DateTime, List<Event>> events = {};
  late ValueNotifier<List<Event>> todayEvents;

  @override
  void initState() {
    super.initState();
    todayEvents = ValueNotifier<List<Event>>(_getEventsForDay(today));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      todayEvents.value = _getEventsForDay(day);
    });
  }

  @override
  void dispose() {
    _eventController.dispose();
    todayEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Training Calendar"),
        ), // Otsikko
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
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        // lisää tapahtuma
                        events.addAll({
                          today: [Event(_eventController.text)]
                        });
                        Navigator.of(context).pop();
                        todayEvents.value = _getEventsForDay(today);
                      },
                      child: Text("Submit"),
                    )
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(day, today),
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2040, 12, 31),
              focusedDay: today,
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: todayEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () => print(""),
                          title: Text('${value[index]}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
