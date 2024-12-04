import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'common/widgets/layout_widget.dart';

class CalendarScreenWrapper extends StatelessWidget {
  const CalendarScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarScreenState(),
      child: MainLayout(
        currentIndex: 1,
        child: const CalendarScreen(),
      ),
    );
  }
}

class CalendarScreenState extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarState = Provider.of<CalendarScreenState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Calendar'),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: calendarState.selectedDate,
            selectedDayPredicate: (day) =>
                isSameDay(day, calendarState.selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              calendarState.updateSelectedDate(selectedDay);
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'start/plan workout'); //lisää treenisivu tähän
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

