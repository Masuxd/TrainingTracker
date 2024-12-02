import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/widgets/layout_widget.dart';

class TrainingTracker extends StatelessWidget {
  const TrainingTracker({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('TrainingTracker built');
    return ChangeNotifierProvider(
      create: (context) => HomeScreenState(),
      child: MainLayout(
        currentIndex: 0,
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreenState extends ChangeNotifier {}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('HomeScreen built');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/start-workout');
            },
            child: Text('Start a Workout'),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/plan-workout');
            },
            child: Text('Plan a workout'),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
