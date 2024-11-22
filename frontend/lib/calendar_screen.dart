import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/widgets/layout_widget.dart';

class CalendarScreenWrapper extends StatelessWidget {
  const CalendarScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarScreenState(),
      child: MainLayout(
        currentIndex: 1,
        child: CalendarScreen(),
      ),
    );
  }
}

class CalendarScreenState extends ChangeNotifier {}

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('CalendarScreen built');
    return Center(
      child: Text('Calendar Screen'),
    );
  }
}
