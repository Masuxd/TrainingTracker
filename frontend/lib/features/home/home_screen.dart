import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrainingTracker extends StatelessWidget {
  const TrainingTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenState(),
      child: HomeScreen(),
    );
  }
}

class HomeScreenState extends ChangeNotifier {}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var state = context.watch<HomeScreenState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Training Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: null,
              child: Text('Start a Workout'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: null,
              child: Text('Plan a workout'),
            ),
          ],
        ),
      ),
    );
  }
}