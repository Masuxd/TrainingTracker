import 'dart:async'; //kello
import 'package:flutter/material.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  late Timer _timer;
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds++;

        if (_seconds == 60) {
          _seconds = 0;
          _minutes++;
        }

        if (_minutes == 60) {
          _minutes = 0;
          _hours++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Exercise Page'),
    ),
    body: Stack(
      children: [
        Center(

        ),
        Positioned(
          top: 20,
          right: 20,
          child: Text(
            'Exercise time: $_hours h $_minutes min $_seconds s',
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
}
}