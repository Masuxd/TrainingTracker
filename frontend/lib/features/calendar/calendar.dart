import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // flutter calendar package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime today = DateTime.now(); //päivämäärä
  Map<DateTime, List> events = {};
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
        body: content(),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        const Text("Hellou"),
        Container(
          child: TableCalendar(
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) => isSameDay(day, today),
            firstDay: DateTime.utc(2010, 1, 1),
            lastDay: DateTime.utc(2040, 12, 31),
            focusedDay: today,
            onDaySelected: _onDaySelected,
          ),
        ),
      ],
    );
  }
}
